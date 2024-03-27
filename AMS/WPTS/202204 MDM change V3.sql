/*
This script was created by Visual Studio on 5/10/2022 at 8:24 AM.
Run this script on usdcwptssqldv01.DisJobHistoryINT1 (WFT\e220932) to make it the same as usdcwptssqldv01.OFIs (WFT\e220932).
This script performs its actions in the following order:
1. Disable foreign-key constraints.
2. Perform DELETE commands. 
3. Perform UPDATE commands.
4. Perform INSERT commands.
5. Re-enable foreign-key constraints.
Please back up your target database before running this script.
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET XACT_ABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
/*Pointer used for text / image updates. This might not be needed, but is declared here just in case*/
DECLARE @pv binary(16)
BEGIN TRANSACTION
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=1
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=2
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=3
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=5
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=6
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=11
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=13
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=14
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=20
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=22
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=23
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=25
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=28
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=29
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=32
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'BSS_AD' WHERE [Level3ID]=34
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'BSS_CM' WHERE [Level3ID]=35
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'BSS_FA' WHERE [Level3ID]=36
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'BSS_GS' WHERE [Level3ID]=37
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'BSS_HR' WHERE [Level3ID]=38
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'BSS_HS' WHERE [Level3ID]=39
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'BSS_IT' WHERE [Level3ID]=40
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'BSS_LG' WHERE [Level3ID]=41
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'BSS_MFG' WHERE [Level3ID]=42
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'BSS_MR' WHERE [Level3ID]=43
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'BSS_OS' WHERE [Level3ID]=44
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'BSS_RE' WHERE [Level3ID]=45
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'BSS_SC' WHERE [Level3ID]=46
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'BSS_SS' WHERE [Level3ID]=47
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'BSS_TT' WHERE [Level3ID]=48
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'COPS_BW' WHERE [Level3ID]=49
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'COPS_OM' WHERE [Level3ID]=50
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'COPS_RD' WHERE [Level3ID]=51
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=52
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'EX_OFF', [Active]=1 WHERE [Level3ID]=54
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_RES' WHERE [Level3ID]=74
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=75
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=78
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_TM' WHERE [Level3ID]=79
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=80
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=81
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'IN_APAC', [Active]=1 WHERE [Level3ID]=83
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'IN_CAN', [Active]=1 WHERE [Level3ID]=84
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'IN_CORP', [Active]=1 WHERE [Level3ID]=85
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'IN_EUC', [Active]=1 WHERE [Level3ID]=86
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'IN_LAM', [Active]=1 WHERE [Level3ID]=88
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'IN_MENA', [Active]=1 WHERE [Level3ID]=89
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'IN_RUS', [Active]=1 WHERE [Level3ID]=90
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'IN_SSA', [Active]=1 WHERE [Level3ID]=91
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'IN_USA', [Active]=1 WHERE [Level3ID]=92
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=95
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'OV3_SSI' WHERE [Level3ID]=100
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=101
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'RE_APAC', [Active]=1 WHERE [Level3ID]=102
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'RE_MENA', [Active]=1 WHERE [Level3ID]=103
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'RE_RIGS', [Active]=1 WHERE [Level3ID]=104
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=105
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_CHW' WHERE [Level3ID]=106
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=107
UPDATE [dbo].[OrgDataLevel3] SET [Level3Name]=N'INTS - Well Abandonment', [Level2ID]=87, [MDMLevel2Code]=N'SUB_DPA' WHERE [Level3ID]=111
UPDATE [dbo].[OrgDataLevel3] SET [Level3Name]=N'INTS - Fishing', [Level2ID]=87, [MDMLevel2Code]=N'SUB_FIS' WHERE [Level3ID]=113
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=115
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=118
UPDATE [dbo].[OrgDataLevel3] SET [Level3Name]=N'INTS - Re Entry', [Level2ID]=87, [MDMLevel2Code]=N'SUB_REE', [Active]=1 WHERE [Level3ID]=122
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=124
UPDATE [dbo].[OrgDataLevel3] SET [Level2ID]=52, [MDMLevel2Code]=N'TTL_WTS' WHERE [Level3ID]=129
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=130
UPDATE [dbo].[OrgDataLevel3] SET [Level3Name]=N'Core Completions', [MDMLevel2Code]=N'TTL_CHC' WHERE [Level3ID]=134
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_CR' WHERE [Level3ID]=136
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_DD' WHERE [Level3ID]=137
UPDATE [dbo].[OrgDataLevel3] SET [Level3Name]=N'MPD Downhole Deployment Valve', [Level2ID]=52, [MDMLevel2Code]=N'TTL_DDV', [Active]=1 WHERE [Level3ID]=138
UPDATE [dbo].[OrgDataLevel3] SET [Level3Name]=N'DRT - Performance Drilling Tools', [Level2ID]=87, [MDMLevel2Code]=N'SUB_DJS', [Active]=1 WHERE [Level3ID]=139
UPDATE [dbo].[OrgDataLevel3] SET [Level3Name]=N'DRT - Drill Pipe & Collars', [Level2ID]=87, [MDMLevel2Code]=N'SUB_DPC', [Active]=1 WHERE [Level3ID]=140
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=141
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=142
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=144
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=145
UPDATE [dbo].[OrgDataLevel3] SET [Level2ID]=86, [MDMLevel2Code]=N'TTL_LABS', [Active]=1 WHERE [Level3ID]=148
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_LWD' WHERE [Level3ID]=151
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_MWD' WHERE [Level3ID]=153
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=154
UPDATE [dbo].[OrgDataLevel3] SET [Level2ID]=77, [MDMLevel2Code]=N'TTL_PA', [Active]=1 WHERE [Level3ID]=156
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=159
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=160
UPDATE [dbo].[OrgDataLevel3] SET [Level2ID]=65, [MDMLevel2Code]=N'TTL_PJ', [Active]=1 WHERE [Level3ID]=162
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_POG' WHERE [Level3ID]=164
UPDATE [dbo].[OrgDataLevel3] SET [Level3Name]=N'Production Software', [Level2ID]=77, [MDMLevel2Code]=N'TTL_PS', [Active]=1 WHERE [Level3ID]=165
UPDATE [dbo].[OrgDataLevel3] SET [Level2ID]=65, [MDMLevel2Code]=N'TTL_PUS', [Active]=1 WHERE [Level3ID]=167
UPDATE [dbo].[OrgDataLevel3] SET [Level3Name]=N'MPD Rotating Control Device', [Level2ID]=52, [MDMLevel2Code]=N'TTL_RCD', [Active]=1 WHERE [Level3ID]=168
UPDATE [dbo].[OrgDataLevel3] SET [Level3Name]=N'Rod Pumps', [Level2ID]=65, [MDMLevel2Code]=N'TTL_ROD', [Active]=1 WHERE [Level3ID]=169
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_RSS' WHERE [Level3ID]=170
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=171
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=173
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_SLIM' WHERE [Level3ID]=174
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=175
UPDATE [dbo].[OrgDataLevel3] SET [Level3Name]=N'Sucker Rods', [Level2ID]=65, [MDMLevel2Code]=N'TTL_SRO', [Active]=1 WHERE [Level3ID]=176
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=177
UPDATE [dbo].[OrgDataLevel3] SET [Level3Name]=N'DRT - Inspection/Machine Shop/TPS', [Level2ID]=87, [MDMLevel2Code]=N'SUB_TPS', [Active]=1 WHERE [Level3ID]=178
UPDATE [dbo].[OrgDataLevel3] SET [Level2ID]=86, [MDMLevel2Code]=N'TTL_WHS' WHERE [Level3ID]=183
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=186
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=188
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'IN_HR', [Active]=1 WHERE [Level3ID]=190
UPDATE [dbo].[OrgDataLevel3] SET [Level3Name]=N'International Assignee - IN HR', [MDMLevel2Code]=N'IN_INHR', [Active]=1 WHERE [Level3ID]=191
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'IN_RIGS', [Active]=1 WHERE [Level3ID]=192
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=194
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_SLS' WHERE [Level3ID]=195
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=197
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=198
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_TTFM' WHERE [Level3ID]=199
UPDATE [dbo].[OrgDataLevel3] SET [Level3Name]=N'Software Solutions', [Level2ID]=77, [MDMLevel2Code]=N'TTL_SFT' WHERE [Level3ID]=200
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=202
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=203
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=205
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=209
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=210
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=211
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=212
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=213
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=215
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_ROS' WHERE [Level3ID]=216
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_TRSS' WHERE [Level3ID]=217
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=218
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=219
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=220
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=221
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=222
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=223
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'BSS_GB' WHERE [Level3ID]=224
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'BSS_OE' WHERE [Level3ID]=225
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'BSS_SA' WHERE [Level3ID]=226
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=227
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=228
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=229
UPDATE [dbo].[OrgDataLevel3] SET [Level3Name]=N'BUS SUPPORT & COMB OPS-DS', [MDMLevel2Code]=N'OV3_DSG' WHERE [Level3ID]=230
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=231
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=232
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=233
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=234
UPDATE [dbo].[OrgDataLevel3] SET [Level3Name]=N'Integrated Services & Projects', [MDMLevel2Code]=N'OV3_ISP' WHERE [Level3ID]=235
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=236
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=237
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=238
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=239
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=240
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=241
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=242
UPDATE [dbo].[OrgDataLevel3] SET [Level3Name]=N'BUS SUPPORT & COMB OPS-WL', [MDMLevel2Code]=N'OV3_WLG' WHERE [Level3ID]=243
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=244
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=245
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=246
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'SUB_FPS' WHERE [Level3ID]=247
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'SUB_HL' WHERE [Level3ID]=248
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=249
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=250
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=251
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'SUB_PCP' WHERE [Level3ID]=252
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=253
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'SUB_PFS' WHERE [Level3ID]=254
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=255
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'SUB_PL' WHERE [Level3ID]=256
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=257
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=258
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=259
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=260
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=261
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=262
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=263
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_AGAS' WHERE [Level3ID]=264
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=265
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=266
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=267
UPDATE [dbo].[OrgDataLevel3] SET [Level3Name]=N'Cementation Products', [MDMLevel2Code]=N'TTL_CEM' WHERE [Level3ID]=268
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=269
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_CMT' WHERE [Level3ID]=270
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_CT' WHERE [Level3ID]=271
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_DF' WHERE [Level3ID]=272
UPDATE [dbo].[OrgDataLevel3] SET [Level2ID]=86, [MDMLevel2Code]=N'TTL_DIS' WHERE [Level3ID]=273
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=274
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=275
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_DWM' WHERE [Level3ID]=276
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_EC' WHERE [Level3ID]=277
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_ESP' WHERE [Level3ID]=278
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=279
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=280
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_LH' WHERE [Level3ID]=281
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=282
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=283
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=284
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_OALS' WHERE [Level3ID]=285
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=286
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=287
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=288
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=289
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=290
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_PPS_SS' WHERE [Level3ID]=291
UPDATE [dbo].[OrgDataLevel3] SET [Level2ID]=86, [MDMLevel2Code]=N'TTL_PSSV' WHERE [Level3ID]=292
UPDATE [dbo].[OrgDataLevel3] SET [Level2ID]=86, [MDMLevel2Code]=N'TTL_PST' WHERE [Level3ID]=293
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=294
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=295
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=296
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=297
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=298
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=299
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_SCS' WHERE [Level3ID]=300
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_SES' WHERE [Level3ID]=301
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_SS' WHERE [Level3ID]=302
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=303
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_TMS' WHERE [Level3ID]=304
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=305
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_WBC' WHERE [Level3ID]=306
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=307
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_WLG' WHERE [Level3ID]=308
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=309
UPDATE [dbo].[OrgDataLevel3] SET [Level3Name]=N'Sand Face Solutions', [MDMLevel2Code]=N'TTL_SCN' WHERE [Level3ID]=310
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=311
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=312
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=313
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_DEG' WHERE [Level3ID]=314
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_DSC' WHERE [Level3ID]=315
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=316
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=317
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=318
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=319
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=320
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=321
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_SSW' WHERE [Level3ID]=322
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=323
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=324
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=325
UPDATE [dbo].[OrgDataLevel3] SET [Level3Name]=N'MPD Capital Sales', [MDMLevel2Code]=N'TTL_CAPS' WHERE [Level3ID]=326
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=327
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=328
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'TTL_OHW' WHERE [Level3ID]=329
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=330
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=331
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=332
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=333
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=334
UPDATE [dbo].[OrgDataLevel3] SET [Level2ID]=86, [MDMLevel2Code]=N'TTL_SLOG', [Active]=1 WHERE [Level3ID]=335
UPDATE [dbo].[OrgDataLevel3] SET [MDMLevel2Code]=N'OV3_OTHPL' WHERE [Level3ID]=336
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=337
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=338
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=339
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=340
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=341
UPDATE [dbo].[OrgDataLevel3] SET [Active]=0 WHERE [Level3ID]=343
UPDATE [dbo].[OrgDataLevel1] SET [Active]=0 WHERE [Level1ID]=4
UPDATE [dbo].[OrgDataLevel1] SET [Active]=0 WHERE [Level1ID]=13
UPDATE [dbo].[OrgDataLevel1] SET [Active]=0 WHERE [Level1ID]=16
UPDATE [dbo].[OrgDataLevel1] SET [Active]=0 WHERE [Level1ID]=20
UPDATE [dbo].[OrgDataLevel1] SET [Level1Name]=N'Other and Shared Services' WHERE [Level1ID]=21
UPDATE [dbo].[OrgDataLevel1] SET [Active]=0 WHERE [Level1ID]=22
UPDATE [dbo].[OrgDataLevel1] SET [Active]=0 WHERE [Level1ID]=23
UPDATE [dbo].[OrgDataLevel1] SET [Active]=0 WHERE [Level1ID]=24
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=1
UPDATE [dbo].[OrgDataLevel4] SET [Active]=1 WHERE [Level4ID]=6
UPDATE [dbo].[OrgDataLevel4] SET [Active]=1 WHERE [Level4ID]=11
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'Operations Mgt' WHERE [Level4ID]=16
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'Office Srvcs' WHERE [Level4ID]=17
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=23
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=24
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=25
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=26
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=27
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=28
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=29
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=30
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=31
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=32
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=134, [MDMLevel3Code]=N'TTL_CHC' WHERE [Level4ID]=33
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=34
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=35
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=36
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=156 WHERE [Level4ID]=38
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=42
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=43
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=45
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=46
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=48
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=49
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=50
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=156 WHERE [Level4ID]=51
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=55
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=169 WHERE [Level4ID]=56
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=57
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=176 WHERE [Level4ID]=58
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=167 WHERE [Level4ID]=61
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=156 WHERE [Level4ID]=62
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=63
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=162 WHERE [Level4ID]=64
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=65
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=162 WHERE [Level4ID]=66
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=162 WHERE [Level4ID]=67
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=68
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=162 WHERE [Level4ID]=69
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=72
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=73
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=165 WHERE [Level4ID]=75
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=77
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=79
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=80
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=81
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=82
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=83
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=84
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=85
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=86
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=88
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=89
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=344, [MDMLevel3Code]=N'TTL_REJ' WHERE [Level4ID]=93
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=94
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=95
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=97
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=98
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=99
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=100
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=101
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=162 WHERE [Level4ID]=102
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'IWS - Optics', [Level3ID]=345, [MDMLevel3Code]=N'TTL_IWS' WHERE [Level4ID]=106
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'IWS - Electronic', [Level3ID]=345, [MDMLevel3Code]=N'TTL_IWS' WHERE [Level4ID]=107
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=346, [MDMLevel3Code]=N'TTL_TTI' WHERE [Level4ID]=118
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=119
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=120
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=136
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=137
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=138
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=139
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=140
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=142
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=143
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=144
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=145
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=146
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=147
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=149
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'SFS - Screens' WHERE [Level4ID]=150
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=151
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=152
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=165 WHERE [Level4ID]=155
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=158
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=159
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=160
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=163
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=166
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=167
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=347, [MDMLevel3Code]=N'OV3_800' WHERE [Level4ID]=172
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=173
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=174
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=176
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=148, [MDMLevel3Code]=N'TTL_LABS' WHERE [Level4ID]=178
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=179
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=180
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=181
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=183
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=185
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=186
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=188
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=190
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=193
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=195
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=357, [MDMLevel3Code]=N'SUB_PCE' WHERE [Level4ID]=196
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=198
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=199
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=139, [MDMLevel3Code]=N'SUB_DJS' WHERE [Level4ID]=200
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=139, [MDMLevel3Code]=N'SUB_DJS' WHERE [Level4ID]=201
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=140, [MDMLevel3Code]=N'SUB_DPC' WHERE [Level4ID]=202
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=140, [MDMLevel3Code]=N'SUB_DPC' WHERE [Level4ID]=203
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=357, [MDMLevel3Code]=N'SUB_PCE' WHERE [Level4ID]=205
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=178, [MDMLevel3Code]=N'SUB_TPS' WHERE [Level4ID]=206
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=140, [MDMLevel3Code]=N'SUB_DPC' WHERE [Level4ID]=207
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=178, [MDMLevel3Code]=N'SUB_TPS' WHERE [Level4ID]=209
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=140, [MDMLevel3Code]=N'SUB_DPC' WHERE [Level4ID]=210
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=211
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=218
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=221
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=224
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=225
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=229
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=233
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=234
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=129, [MDMLevel3Code]=N'TTL_WTS' WHERE [Level4ID]=235
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=236
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=129, [MDMLevel3Code]=N'TTL_WTS' WHERE [Level4ID]=239
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=346, [MDMLevel3Code]=N'TTL_TTI' WHERE [Level4ID]=240
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=138, [MDMLevel3Code]=N'TTL_DDV' WHERE [Level4ID]=242
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=243
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=245
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=168, [MDMLevel3Code]=N'TTL_RCD' WHERE [Level4ID]=249
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'DNU MPD Continuous Flow', [Level3ID]=358, [MDMLevel3Code]=N'OV3_DIT' WHERE [Level4ID]=250
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=254
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=255
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=256
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=257
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=258
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=259
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=262
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'FRE Internal / External Casing Patches' WHERE [Level4ID]=266
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'FRE Wellbore Cleaning' WHERE [Level4ID]=273
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=122, [MDMLevel3Code]=N'SUB_REE' WHERE [Level4ID]=275
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=122, [MDMLevel3Code]=N'SUB_REE' WHERE [Level4ID]=276
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=277
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=278
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=279
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=280
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=281
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=282
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=283
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=284
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=286
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=287
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=288
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=292
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=293
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=336, [MDMLevel3Code]=N'OV3_OTHPL' WHERE [Level4ID]=295
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=296
UPDATE [dbo].[OrgDataLevel4] SET [Active]=1 WHERE [Level4ID]=304
UPDATE [dbo].[OrgDataLevel4] SET [Active]=1 WHERE [Level4ID]=305
UPDATE [dbo].[OrgDataLevel4] SET [Active]=1 WHERE [Level4ID]=306
UPDATE [dbo].[OrgDataLevel4] SET [Active]=1 WHERE [Level4ID]=307
UPDATE [dbo].[OrgDataLevel4] SET [Active]=1 WHERE [Level4ID]=308
UPDATE [dbo].[OrgDataLevel4] SET [Active]=1 WHERE [Level4ID]=309
UPDATE [dbo].[OrgDataLevel4] SET [Active]=1 WHERE [Level4ID]=310
UPDATE [dbo].[OrgDataLevel4] SET [Active]=1 WHERE [Level4ID]=311
UPDATE [dbo].[OrgDataLevel4] SET [Active]=1 WHERE [Level4ID]=312
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=313
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=315
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=319
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=380, [MDMLevel3Code]=N'TTL_RIGS' WHERE [Level4ID]=324
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=381, [MDMLevel3Code]=N'TTL_EPF' WHERE [Level4ID]=325
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=326
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=328
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=329
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=330
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=384, [MDMLevel3Code]=N'TTL_IDPM' WHERE [Level4ID]=332
UPDATE [dbo].[OrgDataLevel4] SET [Active]=1 WHERE [Level4ID]=335
UPDATE [dbo].[OrgDataLevel4] SET [Active]=1 WHERE [Level4ID]=336
UPDATE [dbo].[OrgDataLevel4] SET [Active]=1 WHERE [Level4ID]=337
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=339
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=340
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=341
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=343
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'Client own Maint-Inspection-Repair' WHERE [Level4ID]=344
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'Subsea Services & Intervention Shared Cost' WHERE [Level4ID]=345
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=348
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=350
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=344, [MDMLevel3Code]=N'TTL_REJ' WHERE [Level4ID]=353
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=354
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=355
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=356
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=357
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=358
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=359
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=361
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=362
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=363
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=335 WHERE [Level4ID]=364
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'International Assignee - IN HR', [Active]=1 WHERE [Level4ID]=365
UPDATE [dbo].[OrgDataLevel4] SET [Active]=1 WHERE [Level4ID]=366
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=370
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=162 WHERE [Level4ID]=371
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=372
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'Cased Hole (Pkr-TRSV-FCT)' WHERE [Level4ID]=373
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=376
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=377
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=381
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'DNU WCN Shared Service Cost', [Level3ID]=353, [MDMLevel3Code]=N'OV3_WCC_SSC' WHERE [Level4ID]=384
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=385
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=386
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'FRE Wellbore Cleaning Filtration' WHERE [Level4ID]=387
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=389
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=230, [MDMLevel3Code]=N'OV3_DSG' WHERE [Level4ID]=390
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'DNU COMP Shared Service Cost', [Level3ID]=353, [MDMLevel3Code]=N'OV3_WCC_SSC' WHERE [Level4ID]=391
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=392
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=393
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=394
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=395
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=396
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=397
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'Software Shared Services', [Level3ID]=360, [MDMLevel3Code]=N'OV3_GLBSSC' WHERE [Level4ID]=398
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=399
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=401
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=402
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'GBSC' WHERE [Level4ID]=403
UPDATE [dbo].[OrgDataLevel4] SET [Active]=1 WHERE [Level4ID]=405
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=408
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=409
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=410
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=411
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'Centrigular Jet Pump' WHERE [Level4ID]=416
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=422
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=423
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=432
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=435
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=437
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=441
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=444
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=453
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=454
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=455
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=456
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=457
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=459
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'Unconventional Completions' WHERE [Level4ID]=460
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=462
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=463
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'SFS - Fluids' WHERE [Level4ID]=464
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'SFS - OH Barrier' WHERE [Level4ID]=465
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=466
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=467
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=468
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=469
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=470
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=471
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=472
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=473
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=474
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=475
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=140, [MDMLevel3Code]=N'SUB_DPC' WHERE [Level4ID]=478
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=483
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=496
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=497
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=346, [MDMLevel3Code]=N'TTL_TTI' WHERE [Level4ID]=498
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=499
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=515
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=516
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=518
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=519
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=520
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=521
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=522
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=523
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=524
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=531
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=532
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=533
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=534
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=535
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=536
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=537
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=538
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=539
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=540
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=541
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=542
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=543
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=544
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=545
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=546
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=547
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=548
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=549
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=550
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=551
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=344, [MDMLevel3Code]=N'TTL_REJ' WHERE [Level4ID]=552
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=554
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=555
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=556
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=557
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=558
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=559
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=560
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=564
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=566
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=139, [MDMLevel3Code]=N'SUB_DJS' WHERE [Level4ID]=567
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=568
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=569
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=570
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=571
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=572
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'DNU DEVA Shared Service Cost', [Level3ID]=352, [MDMLevel3Code]=N'OV3_DRE_SSC' WHERE [Level4ID]=573
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=588
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=589
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=591
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=592
UPDATE [dbo].[OrgDataLevel4] SET [Active]=1 WHERE [Level4ID]=596
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=599
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=600
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=601
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=611
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=616
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=618
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=619
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=620
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=621
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=622
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=623
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=624
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=625
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=626
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=627
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=628
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=629
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=630
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=140, [MDMLevel3Code]=N'SUB_DPC' WHERE [Level4ID]=631
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=642
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=643
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=644
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=645
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=646
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=648
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=649
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'DNU PROD Shared Service Cost', [Level3ID]=359, [MDMLevel3Code]=N'OV3_DPS' WHERE [Level4ID]=650
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=651
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=652
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=653
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=654
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=655
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=656
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=657
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=658
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=659
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=662
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=663
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=667
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=383, [MDMLevel3Code]=N'OV3_PMN' WHERE [Level4ID]=670
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=671
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=673
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=674
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=675
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=676
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=677
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=678
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=679
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=680
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=681
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=682
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=683
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=684
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=687
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=688
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=689
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=690
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=691
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=692
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=693
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=694
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=695
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=696
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=243, [MDMLevel3Code]=N'OV3_WLG' WHERE [Level4ID]=697
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'FRE Wellbore Cleaning Perf & Wash', [Level3ID]=111, [MDMLevel3Code]=N'SUB_DPA' WHERE [Level4ID]=698
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=699
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=701
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=702
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=704
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=705
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=706
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=707
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=709
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=711
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=713
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=714
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=716
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=718
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=719
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=721
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=724
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=727
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=731
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=735
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=736
UPDATE [dbo].[OrgDataLevel4] SET [Active]=0 WHERE [Level4ID]=737
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=349, [MDMLevel3Code]=N'TTL_MPDC' WHERE [Level4ID]=738
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=379, [MDMLevel3Code]=N'OV3_PCB' WHERE [Level4ID]=739
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=356, [MDMLevel3Code]=N'TTL_DSS' WHERE [Level4ID]=743
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=348, [MDMLevel3Code]=N'TTL_MPDE' WHERE [Level4ID]=747
UPDATE [dbo].[OrgDataLevel4] SET [Level4Name]=N'DNU Fluid Extraction', [Level3ID]=382, [MDMLevel3Code]=N'OV3_PMM' WHERE [Level4ID]=748
UPDATE [dbo].[OrgDataLevel4] SET [Level3ID]=350, [MDMLevel3Code]=N'TTL_MPDM' WHERE [Level4ID]=749
UPDATE [dbo].[OrgDataLevel2] SET [Level1ID]=21, [MDMLevel1Code]=N'BSS' WHERE [Level2ID]=1
UPDATE [dbo].[OrgDataLevel2] SET [Level1ID]=21, [MDMLevel1Code]=N'COPS' WHERE [Level2ID]=2
UPDATE [dbo].[OrgDataLevel2] SET [Level1ID]=21, [MDMLevel1Code]=N'EXEC' WHERE [Level2ID]=7
UPDATE [dbo].[OrgDataLevel2] SET [Level1ID]=27, [MDMLevel1Code]=N'GPL_DS' WHERE [Level2ID]=10
UPDATE [dbo].[OrgDataLevel2] SET [Active]=0 WHERE [Level2ID]=17
UPDATE [dbo].[OrgDataLevel2] SET [Level1ID]=25, [MDMLevel1Code]=N'GPL_OCH' WHERE [Level2ID]=20
UPDATE [dbo].[OrgDataLevel2] SET [Active]=0 WHERE [Level2ID]=28
UPDATE [dbo].[OrgDataLevel2] SET [Active]=0 WHERE [Level2ID]=30
UPDATE [dbo].[OrgDataLevel2] SET [Active]=0 WHERE [Level2ID]=32
UPDATE [dbo].[OrgDataLevel2] SET [Level1ID]=27, [MDMLevel1Code]=N'GPL_WL' WHERE [Level2ID]=34
UPDATE [dbo].[OrgDataLevel2] SET [Level1ID]=21, [MDMLevel1Code]=N'INAS', [Active]=1 WHERE [Level2ID]=35
UPDATE [dbo].[OrgDataLevel2] SET [Active]=0 WHERE [Level2ID]=38
UPDATE [dbo].[OrgDataLevel2] SET [Level1ID]=25, [MDMLevel1Code]=N'GPL_TRS' WHERE [Level2ID]=39
UPDATE [dbo].[OrgDataLevel2] SET [Level1ID]=27, [MDMLevel1Code]=N'GPL_MPD' WHERE [Level2ID]=52
UPDATE [dbo].[OrgDataLevel2] SET [Level1ID]=25, [MDMLevel1Code]=N'GPL_WLS' WHERE [Level2ID]=53
UPDATE [dbo].[OrgDataLevel2] SET [Active]=0 WHERE [Level2ID]=57
UPDATE [dbo].[OrgDataLevel2] SET [Active]=0 WHERE [Level2ID]=58
UPDATE [dbo].[OrgDataLevel2] SET [Active]=0 WHERE [Level2ID]=60
UPDATE [dbo].[OrgDataLevel2] SET [Active]=0 WHERE [Level2ID]=63
UPDATE [dbo].[OrgDataLevel2] SET [Active]=0 WHERE [Level2ID]=64
UPDATE [dbo].[OrgDataLevel2] SET [Level1ID]=26, [MDMLevel1Code]=N'GPL_ALS' WHERE [Level2ID]=65
UPDATE [dbo].[OrgDataLevel2] SET [Level1ID]=25, [MDMLevel1Code]=N'GPL_CEM' WHERE [Level2ID]=66
UPDATE [dbo].[OrgDataLevel2] SET [Level1ID]=27, [MDMLevel1Code]=N'GPL_DF' WHERE [Level2ID]=67
UPDATE [dbo].[OrgDataLevel2] SET [Active]=0 WHERE [Level2ID]=68
UPDATE [dbo].[OrgDataLevel2] SET [Active]=0 WHERE [Level2ID]=69
UPDATE [dbo].[OrgDataLevel2] SET [Active]=0 WHERE [Level2ID]=70
UPDATE [dbo].[OrgDataLevel2] SET [Active]=0 WHERE [Level2ID]=72
UPDATE [dbo].[OrgDataLevel2] SET [MDMLevel1Code]=N'GPL_ISP' WHERE [Level2ID]=73
UPDATE [dbo].[OrgDataLevel2] SET [Level1ID]=25, [MDMLevel1Code]=N'GPL_LH' WHERE [Level2ID]=74
UPDATE [dbo].[OrgDataLevel2] SET [MDMLevel1Code]=N'GPL_OTHPL' WHERE [Level2ID]=75
UPDATE [dbo].[OrgDataLevel2] SET [Level1ID]=26, [MDMLevel1Code]=N'GPL_PPS' WHERE [Level2ID]=76
UPDATE [dbo].[OrgDataLevel2] SET [Level1ID]=26, [MDMLevel1Code]=N'GPL_PS' WHERE [Level2ID]=77
UPDATE [dbo].[OrgDataLevel2] SET [Active]=0 WHERE [Level2ID]=78
UPDATE [dbo].[OrgDataLevel2] SET [Level1ID]=26, [MDMLevel1Code]=N'GPL_SSI' WHERE [Level2ID]=79
UPDATE [dbo].[OrgDataLevel2] SET [Active]=0 WHERE [Level2ID]=80
UPDATE [dbo].[OrgDataLevel2] SET [Active]=0 WHERE [Level2ID]=81
UPDATE [dbo].[OrgDataLevel2] SET [Active]=0 WHERE [Level2ID]=82
UPDATE [dbo].[OrgDataLevel2] SET [Active]=0 WHERE [Level2ID]=85
GO
SET IDENTITY_INSERT [dbo].[OrgDataLevel2] ON
INSERT INTO [dbo].[OrgDataLevel2] ([Level2ID], [MDMLevel2Code], [Level2Name], [Level1ID], [MDMLevel1Code], [Active]) VALUES (86, N'GPL_DISC', N'Discontinued Product Lines', 21, N'GPL_DISC', 1)
INSERT INTO [dbo].[OrgDataLevel2] ([Level2ID], [MDMLevel2Code], [Level2Name], [Level1ID], [MDMLevel1Code], [Active]) VALUES (87, N'GPL_ISDT', N'Intervention Services & Drilling Tools', 26, N'GPL_ISDT', 1)
INSERT INTO [dbo].[OrgDataLevel2] ([Level2ID], [MDMLevel2Code], [Level2Name], [Level1ID], [MDMLevel1Code], [Active]) VALUES (88, N'GPL_DRE_SSC', N'DRE Shared Services', 27, N'GPL_DRE_SSC', 1)
INSERT INTO [dbo].[OrgDataLevel2] ([Level2ID], [MDMLevel2Code], [Level2Name], [Level1ID], [MDMLevel1Code], [Active]) VALUES (89, N'GPL_WCC_SSC', N'WCC Shared Services', 25, N'GPL_WCC_SSC', 1)
INSERT INTO [dbo].[OrgDataLevel2] ([Level2ID], [MDMLevel2Code], [Level2Name], [Level1ID], [MDMLevel1Code], [Active]) VALUES (90, N'GPL_PRI_SSC', N'PRI Shared Services', 26, N'GPL_PRI_SSC', 1)
INSERT INTO [dbo].[OrgDataLevel2] ([Level2ID], [MDMLevel2Code], [Level2Name], [Level1ID], [MDMLevel1Code], [Active]) VALUES (91, N'GPL_GLBSCC', N'Global Product Shared Services', 28, N'GPL_GLBSCC', 1)
INSERT INTO [dbo].[OrgDataLevel2] ([Level2ID], [MDMLevel2Code], [Level2Name], [Level1ID], [MDMLevel1Code], [Active]) VALUES (92, N'GPL_DRE_ISP', N'DRE ISP GPL', 27, N'DRE', 1)
INSERT INTO [dbo].[OrgDataLevel2] ([Level2ID], [MDMLevel2Code], [Level2Name], [Level1ID], [MDMLevel1Code], [Active]) VALUES (93, N'GPL_WCC_ISP', N'WCC ISP GPL', 25, N'WCC', 1)
INSERT INTO [dbo].[OrgDataLevel2] ([Level2ID], [MDMLevel2Code], [Level2Name], [Level1ID], [MDMLevel1Code], [Active]) VALUES (94, N'GPL_PRI_ISP', N'PRI ISP GPL', 26, N'PRI', 1)
SET IDENTITY_INSERT [dbo].[OrgDataLevel2] OFF
GO
SET IDENTITY_INSERT [dbo].[OrgDataLevel4] ON
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (750, N'PL_152', N'ForeSite Edge', 156, N'TTL_PA', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (751, N'PL_DAF', N'MPD Real-Time Data Services', 322, N'TTL_SSW', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (752, N'PL_DAG', N'MPD After-Market Sales', 326, N'TTL_CAPS', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (753, N'PL_DAH', N'MPD Capital Sales Install/Service', 326, N'TTL_CAPS', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (754, N'PL_DAI', N'MPD Drilling Engineering', 348, N'TTL_MPDE', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (755, N'PL_DAJ', N'MPD IES Solutions', 348, N'TTL_MPDE', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (756, N'PL_DAK', N'Umbilical DDV', 138, N'TTL_DDV', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (757, N'PL_DAL', N'Non-Umbilical DDV', 138, N'TTL_DDV', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (758, N'PL_DAM', N'Land RCD', 168, N'TTL_RCD', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (759, N'PL_DAN', N'Offshore RCD', 168, N'TTL_RCD', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (760, N'PL_DAO', N'MPD Air Drilling', 349, N'TTL_MPDC', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (761, N'PL_DAP', N'Victus', 350, N'TTL_MPDM', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (762, N'PL_DAQ', N'Pressure Pro', 350, N'TTL_MPDM', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (763, N'PL_DAR', N'MPD Integrated Risers', 351, N'OV3_DAR', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (764, N'PL_DAS', N'Completions Service Tools', 134, N'TTL_CHC', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (765, N'PL_DAT', N'IWS - Wireless', 345, N'TTL_IWS', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (766, N'PL_DAU', N'IWS - Isolation Valves (IV-ICV)', 345, N'TTL_IWS', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (767, N'PL_DAV', N'DRE Segment Shared Cost', 352, N'OV3_DRE_SSC', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (768, N'PL_DAW', N'WCC Segment Shared Cost', 353, N'OV3_WCC_SSC', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (769, N'PL_DAX', N'PRI Segment Shared Cost', 354, N'OV3_DAX', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (770, N'PL_DAZ', N'MPD ISP', 355, N'OV3_DAZ', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (771, N'PL_GPL', N'Global Product Lines Shared', 360, N'OV3_GLBSSC', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (772, N'PL_IN_INAS', N'INT ASSIGNEE-HOUSTON PAYROLL', 361, N'OV3_IN_INAS', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (773, N'PL_OAO', N'Drilling Fluids ISP', 362, N'OV3_OAO', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (774, N'PL_OAP', N'Drilling Services ISP', 363, N'OV3_OAP', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (775, N'PL_OAQ', N'Wireline ISP', 364, N'OV3_OAQ', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (776, N'PL_OAR', N'DRE ISP Other', 365, N'OV3_DRE_ISP', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (777, N'PL_OAT', N'TRS ISP', 366, N'OV3_OAT', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (778, N'PL_OAU', N'Cementing ISP', 367, N'OV3_OAU', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (779, N'PL_OAV', N'Completions ISP', 368, N'OV3_OAV', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (780, N'PL_OAW', N'Liner Hangers ISP', 369, N'OV3_OAW', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (781, N'PL_OAX', N'Well Services ISP', 370, N'OV3_OAX', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (782, N'PL_OAY', N'WCC ISP Other', 371, N'OV3_OAY', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (783, N'PL_OAZ', N'ISDT ISP', 372, N'OV3_OAZ', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (784, N'PL_OBA', N'ALS ISP', 373, N'OV3_OBA', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (785, N'PL_OBB', N'Production Software ISP', 374, N'OV3_OBB', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (786, N'PL_OBC', N'Testing ISP', 375, N'OV3_OBC', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (787, N'PL_OBD', N'Pressure Pumping ISP', 376, N'OV3_OBD', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (788, N'PL_OBE', N'Sub Sea Intervention ISP', 100, N'OV3_SSI', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (789, N'PL_OBF', N'PRI ISP Other', 377, N'OV3_OBF', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (790, N'PL_PAS', N'WL Software', 378, N'OV3_PAS', 1, 1, 1)
INSERT INTO [dbo].[OrgDataLevel4] ([Level4ID], [MDMLevel4Code], [Level4Name], [Level3ID], [MDMLevel3Code], [InNewJobList], [EnabledInJobList], [Active]) VALUES (791, N'PL_UNA', N'Product Line - Other Unallocated', 336, N'OV3_OTHPL', 1, 1, 1)
SET IDENTITY_INSERT [dbo].[OrgDataLevel4] OFF
GO
SET IDENTITY_INSERT [dbo].[OrgDataLevel1] ON
INSERT INTO [dbo].[OrgDataLevel1] ([Level1ID], [MDMLevel1Code], [Level1Name], [Active]) VALUES (25, N'WCC', N'Well Construction & Completions', 1)
INSERT INTO [dbo].[OrgDataLevel1] ([Level1ID], [MDMLevel1Code], [Level1Name], [Active]) VALUES (26, N'PRI', N'Production & Intervention', 1)
INSERT INTO [dbo].[OrgDataLevel1] ([Level1ID], [MDMLevel1Code], [Level1Name], [Active]) VALUES (27, N'DRE', N'Drilling & Evaluation', 1)
INSERT INTO [dbo].[OrgDataLevel1] ([Level1ID], [MDMLevel1Code], [Level1Name], [Active]) VALUES (28, N'GPL_GLBSSC', N'Global Product Shared Services', 1)
SET IDENTITY_INSERT [dbo].[OrgDataLevel1] OFF
GO
SET IDENTITY_INSERT [dbo].[OrgDataLevel3] ON
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (344, N'TTL_REJ', N'Rejuvenation', 53, N'TTL_REJ', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (345, N'TTL_IWS', N'Intelligent Well Systems', 20, N'TTL_IWS', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (346, N'TTL_TTI', N'Thru-Tubing Intervention', 53, N'TTL_TTI', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (347, N'OV3_800', N'BUS SUPPORT & COMB OPS-MPD', 52, N'GPL_MPD', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (348, N'TTL_MPDE', N'MPD Engineering', 52, N'TTL_MPDE', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (349, N'TTL_MPDC', N'MPD Compression', 52, N'TTL_MPDC', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (350, N'TTL_MPDM', N'MPD Manifold Systems', 52, N'TTL_MPDM', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (351, N'OV3_DAR', N'MPD Integrated Risers', 52, N'GPL_MPD', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (352, N'OV3_DRE_SSC', N'DRE Shared Services', 88, N'OV3_DRE_SSC', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (353, N'OV3_WCC_SSC', N'WCC Shared Services', 89, N'OV3_WCC_SSC', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (354, N'OV3_DAX', N'PRI Shared Services', 90, N'GPL_PRI_SSC', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (355, N'OV3_DAZ', N'MPD ISP', 52, N'GPL_MPD', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (356, N'TTL_DSS', N'DS Software', 10, N'GPL_DS', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (357, N'SUB_PCE', N'DRT - Pressure Control Equipment', 87, N'SUB_PCE', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (358, N'OV3_DIT', N'Continuous Flow', 52, N'GPL_MPD', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (359, N'OV3_DPS', N'PRI Shared Services', 90, N'GPL_PRI_SSC', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (360, N'OV3_GLBSSC', N'Global Product Shared Services', 91, N'OV3_GLBSSC', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (361, N'OV3_IN_INAS', N'INT ASSIGNEE-HOUSTON PAYROLL', 35, N'INAS', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (362, N'OV3_OAO', N'Drilling Fluids ISP', 67, N'GPL_DF', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (363, N'OV3_OAP', N'Drilling Services ISP', 10, N'GPL_DS', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (364, N'OV3_OAQ', N'Wireline ISP', 34, N'GPL_WL', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (365, N'OV3_DRE_ISP', N'DRE ISP GPL', 92, N'GPL_DRE_ISP', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (366, N'OV3_OAT', N'TRS ISP', 39, N'GPL_TRS', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (367, N'OV3_OAU', N'Cementing ISP', 66, N'GPL_CEM', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (368, N'OV3_OAV', N'Completions ISP', 20, N'GPL_OCH', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (369, N'OV3_OAW', N'Liner Hangers ISP', 74, N'GPL_LH', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (370, N'OV3_OAX', N'Well Services ISP', 53, N'GPL_WLS', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (371, N'OV3_OAY', N'WCC ISP Other', 93, N'GPL_WCC_ISP', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (372, N'OV3_OAZ', N'ISDT ISP', 87, N'GPL_ISDT', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (373, N'OV3_OBA', N'ALS ISP', 65, N'GPL_ALS', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (374, N'OV3_OBB', N'Production Software ISP', 77, N'GPL_PS', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (375, N'OV3_OBC', N'Testing ISP', 52, N'GPL_MPD', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (376, N'OV3_OBD', N'Pressure Pumping ISP', 76, N'GPL_PPS', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (377, N'OV3_OBF', N'PRI ISP GPL', 94, N'GPL_PRI_ISP', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (378, N'OV3_PAS', N'WL Software', 34, N'GPL_WL', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (379, N'OV3_PCB', N'Separation System', 52, N'GPL_MPD', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (380, N'TTL_RIGS', N'Land Drilling Rigs', 86, N'GPL_DISC', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (381, N'TTL_EPF', N'Early Production Facilities', 86, N'GPL_DISC', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (382, N'OV3_PMM', N'Fluid Extraction', 52, N'GPL_MPD', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (383, N'OV3_PMN', N'BUS SUPPORT & COMB OPS-DF', 67, N'GPL_DF', 1)
INSERT INTO [dbo].[OrgDataLevel3] ([Level3ID], [MDMLevel3Code], [Level3Name], [Level2ID], [MDMLevel2Code], [Active]) VALUES (384, N'TTL_IDPM', N'Integrated Drilling - Project Management', 86, N'GPL_DISC', 1)
SET IDENTITY_INSERT [dbo].[OrgDataLevel3] OFF
COMMIT TRANSACTION
