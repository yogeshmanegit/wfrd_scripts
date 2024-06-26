select
  distinct T.ID,
  T.SAPID,
  T.JDEAssetNumber,
  T.SerialNumber,
  T.ToolPanelTypeID,
  T.ToolCodeTypeID,
  TR.RepairID as RepairID,
  TR.RepairComplete,
  (
    select
      max(RepairDate)
    from
      ToolHistory
    where
      RepairID = TR.RepairID
  ) as RepairDate,
  PMR.ID as PMRuleID,
  PMR.MaxRuns as PMRMaxRuns,
  PMT.ID as PMTypeID,
  PMT.Name as PMTypeName,

  (
    case when PMT.RunsSetting = 1
    and PMR.MaxRuns > 0 then coalesce (
      (
        select
          case when count(ot.run)>= 0 then count(ot.run) else NULL end
        from
          logoperationtool lot
          left join logoperation lo on (
            lo.operationid = lot.operationid
            and lo.unitid = lot.unitid
            and lo.serviceorderid = lot.serviceorderid
          )
          left join operationtype ot on ot.id = lo.operationtypeid
        where
          lo.deleted is null
          and lot.toolid = t.id
          and lo.starttime > coalesce(
            (
              select
                max(TH2.RepairDate):: date
              from
                ToolHistory TH2,
                ToolRepair TR2,
                PMRule PMR2
              where
                TH2.RepairID = TR2.RepairID
                and TH2.PMRuleID = PMR2.ID
                and PMR2.PMTypeID = PMR.PMTypeID
                and TH2.ToolID = T.ID
                and TR2.RepairComplete = 1
            ),
            PMR.StartDate
          )
      ),
      (
        select
          case when count(ot.run)>= 0 then count(ot.run) else NULL end
        from
          logoperationtool lot
          left join logoperation lo on (
            lo.operationid = lot.operationid
            and lo.unitid = lot.unitid
            and lo.serviceorderid = lot.serviceorderid
          )
          left join operationtype ot on ot.id = lo.operationtypeid
        where
          lo.deleted is null
          and lot.toolid = t.id
      ),
      0
    ) else NULL end
  ) as AlreadyPresentOnRuns --PMDueRuns

from
  PMRule PMR
  INNER JOIN UserSettings US on (
    US.ID = texttovarchar(PMR.LastModifiedBy)
  )
  INNER JOIN PMType PMT on (PMR.PMTypeID = PMT.ID)
  INNER JOIN Tool T on (1 = 1)
  INNER JOIN (
    PMToolType PMTT
    INNER JOIN PMToolTypeRules PTTR on (PMTT.ID = PTTR.PMToolTypeID)
  ) on (
    PMR.ID = PMTT.PMRuleID
    and PMTT.ToolPanelTypeID = T.ToolPanelTypeID
    and PMTT.ToolCodeTypeID = T.ToolCodeTypeID
  )
  LEFT JOIN (
    (
      ToolHistory TH
      INNER JOIN ToolRepair TR on (
        TH.PMRuleID is not NULL
        and TH.RepairID = TR.RepairID
        and (
          TR.RepairComplete = 0
          or TR.RepairComplete is null
        )
      )
    )
  ) on (
    PMR.ID = TH.PMRuleID
    and T.ID = TH.ToolID
  )
  LEFT JOIN ToolPanelCodeVersion TPCV ON (
    TPCV.ID = T.ToolPanelCodeVersionID
  )
  LEFT JOIN PMRule_DateRange PMRDR ON (PMR.ID = PMRDR.PMRuleID),
  Station Station
where
  jdeassetnumber > 0
  and case when PMR.Obsolete = 0
  or PMR.Obsolete is null then TRUE when PMR.obsolete = 1
  and TR.RepairComplete = 1 then TRUE else FALSE end
  and (
    case when TR.RepairedStationID is not null then TR.RepairedStationID else T.StationID end
  ) = Station.ID
  and (
    T.ToolStatusID not in (7, 12)
    or TR.RepairComplete = 1
    or T.ToolStatusID not in (1)
    and exists (
      select
        *
      from
        ToolHistory TH4
      where
        TH4.RepairID = TR.RepairID
        and TH4.ToolID = T.ID
    )
  )
  and (
    (
      PTTR.ColumnID = 1
      and PMTT.Version = T.Version
      and not exists (
        select
          PMR2.ID
        from
          PMRule PMR2,
          PMToolType PMTT2,
          PMToolTypeRules PTTR2
        where
          PMR2.ID = PMTT2.PMRuleID
          and PMR2.Obsolete = 0
          and PMR2.PMTypeID = PMR.PMTypeID
          and PMTT2.ToolPanelTypeID = T.ToolPanelTypeID
          and PMTT2.ToolCodeTypeID = T.ToolCodeTypeID
          and PMTT2.ID = PTTR2.PMToolTypeID
          and PTTR2.ColumnID = 2
          and PTTR2.ColumnValue = (
            select
              RegionID
            from
              Country
            where
              ID = Station.CountryID
          )
          and (
            PMTT2.Version = T.Version
            or PMTT2.Version is null
          )
          and (
            PMR.MaxDays > 0
            and (
              PMR.MaxDays >= PMR2.MaxDays
              or PMR.MaxRuns >= PMR2.MaxRuns
            )
            or PMR.MaxCMLs > 0
            and PMR.MaxCMLs >= PMR2.MaxCMLs
          )
        union
        select
          PMR2.ID
        from
          PMRule PMR2,
          PMToolType PMTT2,
          PMToolTypeRules PTTR2,
          PMRule_DateRange PMRDR2
        where
          PMR2.ID = PMTT2.PMRuleID
          and PMR2.Obsolete = 0
          and PMR2.PMTypeID = PMR.PMTypeID
          and PMTT2.ToolPanelTypeID = T.ToolPanelTypeID
          and PMTT2.ToolCodeTypeID = T.ToolCodeTypeID
          and PMTT2.ID = PTTR2.PMToolTypeID
          and PTTR2.ColumnID = 2
          and PTTR2.ColumnValue = (
            select
              RegionID
            from
              Country
            where
              ID = Station.CountryID
          )
          and (
            PMTT2.Version = T.Version
            or PMTT2.Version is null
          )
          and PMR.MaxDays = 0
          and PMRDR2.PMRuleID = PMR2.ID
        union
        select
          PMR.ID
        from
          PMRule PMR2,
          PMToolType PMTT2,
          PMToolTypeRules PTTR2
        where
          PMR2.ID = PMTT2.PMRuleID
          and PMR2.Obsolete = 0
          and PMR2.PMTypeID = PMR.PMTypeID
          and PMTT2.ToolPanelTypeID = T.ToolPanelTypeID
          and PMTT2.ToolCodeTypeID = T.ToolCodeTypeID
          and PMTT2.ID = PTTR2.PMToolTypeID
          and PTTR2.ColumnID = 3
          and PTTR2.ColumnValue = Station.CountryID
          and (
            PMTT2.Version = T.Version
            or PMTT2.Version is null
          )
          and (
            PMR.MaxDays > 0
            and (
              PMR.MaxDays >= PMR2.MaxDays
              or PMR.MaxRuns >= PMR2.MaxRuns
            )
            or PMR.MaxCMLs > 0
            and PMR.MaxCMLs >= PMR2.MaxCMLs
          )
        union
        select
          PMR.ID
        from
          PMRule PMR2,
          PMToolType PMTT2,
          PMToolTypeRules PTTR2,
          PMRule_DateRange PMRDR2
        where
          PMR2.ID = PMTT2.PMRuleID
          and PMR2.Obsolete = 0
          and PMR2.PMTypeID = PMR.PMTypeID
          and PMTT2.ToolPanelTypeID = T.ToolPanelTypeID
          and PMTT2.ToolCodeTypeID = T.ToolCodeTypeID
          and PMTT2.ID = PTTR2.PMToolTypeID
          and PTTR2.ColumnID = 3
          and PTTR2.ColumnValue = Station.CountryID
          and (
            PMTT2.Version = T.Version
            or PMTT2.Version is null
          )
          and PMR.MaxDays = 0
          and PMRDR2.PMRuleID = PMR2.ID
      )
    )
    or (
      PTTR.ColumnID = 1
      and PMTT.Version is null
      and not exists (
        select
          PMR.ID
        from
          PMRule PMR2,
          PMToolType PMTT2,
          PMToolTypeRules PTTR2
        where
          PMR2.ID = PMTT2.PMRuleID
          and PMR2.Obsolete = 0
          and PMR2.PMTypeID = PMR.PMTypeID
          and PMTT2.ToolPanelTypeID = T.ToolPanelTypeID
          and PMTT2.ToolCodeTypeID = T.ToolCodeTypeID
          and PMTT2.ID = PTTR2.PMToolTypeID
          and PTTR2.ColumnID = 1
          and PMTT2.Version = T.Version
        union
        select
          PMR.ID
        from
          PMRule PMR2,
          PMToolType PMTT2,
          PMToolTypeRules PTTR2
        where
          PMR2.ID = PMTT2.PMRuleID
          and PMR2.Obsolete = 0
          and PMR2.PMTypeID = PMR.PMTypeID
          and PMTT2.ToolPanelTypeID = T.ToolPanelTypeID
          and PMTT2.ToolCodeTypeID = T.ToolCodeTypeID
          and PMTT2.ID = PTTR2.PMToolTypeID
          and PTTR2.ColumnID = 2
          and PTTR2.ColumnValue = (
            select
              RegionID
            from
              Country
            where
              ID = Station.CountryID
          )
          and (
            PMTT2.Version = T.Version
            or PMTT2.Version is null
          )
          and (
            PMR.MaxDays > 0
            and (
              PMR.MaxDays >= PMR2.MaxDays
              or PMR.MaxRuns >= PMR2.MaxRuns
            )
            or PMR.MaxCMLs > 0
            and PMR.MaxCMLs >= PMR2.MaxCMLs
          )
        union
        select
          PMR.ID
        from
          PMRule PMR2,
          PMToolType PMTT2,
          PMToolTypeRules PTTR2,
          PMRule_DateRange PMRDR2
        where
          PMR2.ID = PMTT2.PMRuleID
          and PMR2.Obsolete = 0
          and PMR2.PMTypeID = PMR.PMTypeID
          and PMTT2.ToolPanelTypeID = T.ToolPanelTypeID
          and PMTT2.ToolCodeTypeID = T.ToolCodeTypeID
          and PMTT2.ID = PTTR2.PMToolTypeID
          and PTTR2.ColumnID = 2
          and PTTR2.ColumnValue = (
            select
              RegionID
            from
              Country
            where
              ID = Station.CountryID
          )
          and (
            PMTT2.Version = T.Version
            or PMTT2.Version is null
          )
          and PMR.MaxDays = 0
          and PMRDR2.PMRuleID = PMR2.ID
        union
        select
          PMR.ID
        from
          PMRule PMR2,
          PMToolType PMTT2,
          PMToolTypeRules PTTR2
        where
          PMR2.ID = PMTT2.PMRuleID
          and PMR2.Obsolete = 0
          and PMR2.PMTypeID = PMR.PMTypeID
          and PMTT2.ToolPanelTypeID = T.ToolPanelTypeID
          and PMTT2.ToolCodeTypeID = T.ToolCodeTypeID
          and PMTT2.ID = PTTR2.PMToolTypeID
          and PTTR2.ColumnID = 3
          and PTTR2.ColumnValue = Station.CountryID
          and (
            PMTT2.Version = T.Version
            or PMTT2.Version is null
          )
          and (
            PMR.MaxDays > 0
            and (
              PMR.MaxDays >= PMR2.MaxDays
              or PMR.MaxRuns >= PMR2.MaxRuns
            )
            or PMR.MaxCMLs > 0
            and PMR.MaxCMLs >= PMR2.MaxCMLs
          )
        union
        select
          PMR.ID
        from
          PMRule PMR2,
          PMToolType PMTT2,
          PMToolTypeRules PTTR2,
          PMRule_DateRange PMRDR2
        where
          PMR2.ID = PMTT2.PMRuleID
          and PMR2.Obsolete = 0
          and PMR2.PMTypeID = PMR.PMTypeID
          and PMTT2.ToolPanelTypeID = T.ToolPanelTypeID
          and PMTT2.ToolCodeTypeID = T.ToolCodeTypeID
          and PMTT2.ID = PTTR2.PMToolTypeID
          and PTTR2.ColumnID = 3
          and PTTR2.ColumnValue = Station.CountryID
          and (
            PMTT2.Version = T.Version
            or PMTT2.Version is null
          )
          and PMR.MaxDays = 0
          and PMRDR2.PMRuleID = PMR2.ID
      )
    )
    or (
      PTTR.ColumnID = 2
      and PMTT.Version = T.Version
      and PTTR.ColumnValue = (
        select
          RegionID
        from
          Country
        where
          ID = Station.CountryID
      )
    )
    or (
      PTTR.ColumnID = 2
      and PMTT.Version is null
      and PTTR.ColumnValue = (
        select
          RegionID
        from
          Country
        where
          ID = Station.CountryID
      )
      and not exists (
        select
          PMR.ID
        from
          PMRule PMR2,
          PMToolType PMTT2,
          PMToolTypeRules PTTR2
        where
          PMR2.ID = PMTT2.PMRuleID
          and PMR2.Obsolete = 0
          and PMR2.PMTypeID = PMR.PMTypeID
          and PMTT2.ToolPanelTypeID = T.ToolPanelTypeID
          and PMTT2.ToolCodeTypeID = T.ToolCodeTypeID
          and PMTT2.ID = PTTR2.PMToolTypeID
          and (
            PTTR2.ColumnID = 1
            or PTTR2.ColumnID = 2
          )
          and PMTT2.Version = T.Version
          and (
            PMR.MaxDays > 0
            and (
              PMR.MaxDays >= PMR2.MaxDays
              or PMR.MaxRuns >= PMR2.MaxRuns
            )
            or PMR.MaxCMLs > 0
            and PMR.MaxCMLs >= PMR2.MaxCMLs
          )
        union
        select
          PMR.ID
        from
          PMRule PMR2,
          PMToolType PMTT2,
          PMToolTypeRules PTTR2
        where
          PMR2.ID = PMTT2.PMRuleID
          and PMR2.Obsolete = 0
          and PMR2.PMTypeID = PMR.PMTypeID
          and PMTT2.ToolPanelTypeID = T.ToolPanelTypeID
          and PMTT2.ToolCodeTypeID = T.ToolCodeTypeID
          and PMTT2.ID = PTTR2.PMToolTypeID
          and PTTR2.ColumnID = 3
          and PTTR2.ColumnValue = Station.CountryID
          and (
            PMTT2.Version = T.Version
            or PMTT2.Version is null
          )
          and (
            PMR.MaxDays > 0
            and (
              PMR.MaxDays >= PMR2.MaxDays
              or PMR.MaxRuns >= PMR2.MaxRuns
            )
            or PMR.MaxCMLs > 0
            and PMR.MaxCMLs >= PMR2.MaxCMLs
          )
        union
        select
          PMR.ID
        from
          PMRule PMR2,
          PMToolType PMTT2,
          PMToolTypeRules PTTR2,
          PMRule_DateRange PMRDR2
        where
          PMR2.ID = PMTT2.PMRuleID
          and PMR2.Obsolete = 0
          and PMR2.PMTypeID = PMR.PMTypeID
          and PMTT2.ToolPanelTypeID = T.ToolPanelTypeID
          and PMTT2.ToolCodeTypeID = T.ToolCodeTypeID
          and PMTT2.ID = PTTR2.PMToolTypeID
          and PTTR2.ColumnID = 3
          and PTTR2.ColumnValue = Station.CountryID
          and (
            PMTT2.Version = T.Version
            or PMTT2.Version is null
          )
          and PMR.MaxDays = 0
          and PMRDR2.PMRuleID = PMR2.ID
      )
    )
    or (
      PTTR.ColumnID = 3
      and PMTT.Version = T.Version
      and PTTR.ColumnValue = Station.CountryID
    )
    or (
      PTTR.ColumnID = 3
      and PMTT.Version is null
      and PTTR.ColumnValue = Station.CountryID
      and not exists (
        select
          PMR.ID
        from
          PMRule PMR2,
          PMToolType PMTT2,
          PMToolTypeRules PTTR2
        where
          PMR2.ID = PMTT2.PMRuleID
          and PMR2.Obsolete = 0
          and PMR2.PMTypeID = PMR.PMTypeID
          and PMTT2.ToolPanelTypeID = T.ToolPanelTypeID
          and PMTT2.ToolCodeTypeID = T.ToolCodeTypeID
          and PMTT2.ID = PTTR2.PMToolTypeID
          and (
            PTTR2.ColumnID = 1
            or PTTR2.ColumnID = 2
            or PTTR2.ColumnID = 3
          )
          and PMTT2.Version = T.Version
          and PTTR2.ColumnValue = Station.CountryID
          and (
            PMR.MaxDays > 0
            and (
              PMR.MaxDays >= PMR2.MaxDays
              or PMR.MaxRuns >= PMR2.MaxRuns
            )
            or PMR.MaxCMLs > 0
            and PMR.MaxCMLs >= PMR2.MaxCMLs
          )
        union
        select
          PMR.ID
        from
          PMRule PMR2,
          PMToolType PMTT2,
          PMToolTypeRules PTTR2,
          PMRule_DateRange PMRDR2
        where
          PMR2.ID = PMTT2.PMRuleID
          and PMR2.Obsolete = 0
          and PMR2.PMTypeID = PMR.PMTypeID
          and PMTT2.ToolPanelTypeID = T.ToolPanelTypeID
          and PMTT2.ToolCodeTypeID = T.ToolCodeTypeID
          and PMTT2.ID = PTTR2.PMToolTypeID
          and (
            PTTR2.ColumnID = 1
            or PTTR2.ColumnID = 2
            or PTTR2.ColumnID = 3
          )
          and PTTR2.ColumnValue = Station.CountryID
          and PMTT2.Version = T.Version
          and PMR.MaxDays = 0
          and PMRDR2.PMRuleID = PMR2.ID
      )
    )
  )
  -- here is the filter
  --and T.ID = 5848154
  and case when PMR.MaxDays = 0 then (
    select
      case when PMRDR.frommonth < PMRDR.tomonth
      and substr(foo6, 6, 2):: int between PMRDR.frommonth
      and PMRDR.tomonth then true when (
        PMRDR.frommonth > PMRDR.tomonth
        and (
          substr(foo6, 6, 2):: int between PMRDR.frommonth
          and 12
          or substr(foo6, 6, 2):: int between 1
          and PMRDR.tomonth
        )
      ) then true else false end
    from
      (
        select
          (
            coalesce (
              (
                select
                  max(TH2.RepairDate):: date as foo5
                from
                  ToolHistory TH2,
                  ToolRepair TR2,
                  PMRule PMR2
                where
                  TH2.RepairID = TR2.RepairID
                  and TH2.PMRuleID = PMR2.ID
                  and PMR2.PMTypeID = PMR.PMTypeID
                  and TH2.ToolID = T.ID
                  and TR2.RepairComplete = 1
                  and (
                    TR.RepairID is null
                    or (TR.RepairID > TR2.RepairID)
                  )
              ),
              (
                select
                  max(foo)
                from
                  (
                    select
                      PMR.StartDate as foo
                    union
                    select
                      T.CreationDate
                  ) as bar
              )
            ):: date
          ):: date as foo6
      ) as foo7
  ) else true end
  and (
    coalesce (
      (
        select
          max(TH2.RepairDate):: date
        from
          ToolHistory TH2,
          ToolRepair TR2,
          PMRule PMR2
        where
          TH2.RepairID = TR2.RepairID
          and TH2.PMRuleID = PMR2.ID
          and PMR2.PMTypeID = PMR.PMTypeID
          and TH2.ToolID = T.ID
          and TR2.RepairComplete = 1
          and (
            TR.RepairID is null
            or (TR.RepairID > TR2.RepairID)
          )
      ),
      (
        select
          max(foo)
        from
          (
            select
              PMR.StartDate as foo
            union
            select
              T.CreationDate
          ) as bar
      )
    ):: date + PMR.MaxDays
  ) >= '0001-01-01'
order by
  PMTypeID
