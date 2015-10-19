/*
 *  Common.h
 *  MyProto
 *
 *  Created by Rahul on 16/12/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#define kMedicalDatabaseName @"medica.sqlite"
#define kNotesDatabaseName @"Notes.sqlite"
#define RemLoadImageResource(path)   [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:@"png"]]

#define TAG_NAME @"<NAME>"
#define TAG_SUBH @"<SUBH>"
#define TAG_GENERAL @"<GENERALDESC>"

#define K_REM_NAME @"Name"
#define	K_INDEX_SUBH 1
#define K_INDEX_GENERAL 2
#define K_INDEX_MIND 3
#define K_INDEX_HEAD 4
#define K_INDEX_FACE 5
#define K_INDEX_EYES 6
#define K_INDEX_EARS 7
#define K_INDEX_NOSE 8
#define K_INDEX_MOUTH 9
#define K_INDEX_HEART 10
#define K_INDEX_CHEST 11
#define K_INDEX_STOMACH 12
#define K_INDEX_ABDOMEN 13 
#define K_INDEX_RECTUM 14 
#define K_INDEX_URINARY 15
#define K_INDEX_RESPIRATORY 16
#define K_INDEX_EXTREMETIES 17
#define K_INDEX_SKIN 18
#define K_INDEX_MALE 19
#define K_INDEX_FEMALE 20
#define K_INDEX_FEVER 21
#define K_INDEX_BACK 22
#define K_INDEX_SLEEP 23
#define K_INDEX_MODALITIES 24
#define K_INDEX_RCOMPARE 25
#define K_INDEX_RCOMPLIMENT 26
#define K_INDEX_RANTIDOTE 27
#define K_INDEX_DOSE 28
#define K_INDEX_THROAT 29
#define K_INDEX_SEXUAL 30

#define K_INDEX_RGENERAL 31
#define K_INDEX_USES 32
#define K_INDEX_STOOL 33
#define K_INDEX_TISSUES 34
#define K_INDEX_NERVES 35

#define K_INDEX_BONES 36
#define K_INDEX_RINCOMPATIBLE 37
#define K_INDEX_TONGUE 38
#define K_INDEX_CIRCULATORY 39
#define K_INDEX_BLOOD 40
#define K_INDEX_SPINE 41
#define K_INDEX_BOWELS 42
#define K_INDEX_TEETH 43
#define K_INDEX_BREAST 44
#define K_INDEX_KIDNEY 45
#define K_INDEX_GASTRO 46
#define K_INDEX_SPLEEN 47
#define K_INDEX_NECK 48
#define K_INDEX_URIN_PART 49
#define K_INDEX_PHYSIO_DOSAGE 50
#define K_INDEX_AILMENTARY_CANAL 51
#define K_INDEX_RCOMPATIBLE 52
#define K_INDEX_RINIMICAL 53
#define K_INDEX_LIVER 54


#define KEY_LIST @"Name", @"Subheading",@"Generaldesc", @"Mind",@"Head", @"Face",@"Eyes", @"Ears", \
@"Nose",@"Mouth",@"HEART",@"Chest",@"Stomach", @"Abdomen",@"Rectum",@"Urinary",@"Respiratory",@"Extremities",\
@"Skin",@"Male",@"Female",@"Fever",@"Back",@"Sleep",@"Modalities",@"Rcompare",@"Rcompliment",@"Rantidote",@"Dose",@"Throat",@"Sexual", \
@"Rgeneral",@"Uses",@"Stool",@"Tissues",@"Nerves",@"Bones",@"Rincompatible",@"Tongue",@"Circulatory",@"Blood",@"Spine",@"Bowels",@"Teeth", \
@"Breast",@"Kidney",@"Gastro",@"Spleen",@"Neck",@"Urine",@"PhysiologicDosage",@"AlimentaryCanal",@"Rcompatible",@"Rinimical",@"Liver"

#define HTML_FILE @"Message.htm"
#define FAQ_FILE @"FAQ.htm"
#define ALPHA_ARRAY [NSArray arrayWithObjects: @"A", @"B", @"C", @"D", @"E", @"F",@"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S",@"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil] 
#define ALPHA_CNT 26
#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"

#define TABLE_TOP_ROW_IMAGE_NAME @"table_top.png"
#define TABLE_MIDDLE_ROW_IMAGE_NAME @"table_middle.png"
#define TABLE_BOTTOM_ROW_IMAGE_NAME @"table_bottom.png"
#define TABLE_SINGLE_ROW_IMAGE_NAME @"tablecellSinglerow.png"
#define TABLE_ACCESSORY_IMAGE_NAME  @"TableCellArrow.png"
#define defaulttintcolor [UIColor colorWithRed:.298 green:.298 blue:.298 alpha:0]