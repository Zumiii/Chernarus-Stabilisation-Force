/*

	GUI defines

*/


#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_HITZONES         17
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102
#define CT_CHECKBOX         77
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C
#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0
#define ST_UPPERCASE      0xC0
#define ST_LOWERCASE      0xD0
#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800
#define ST_TITLE          ST_TITLE_BAR + ST_CENTER
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400
#define SL_TEXTURES       0x10
#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20
#define TOSTRING(TEXT)	  #TEXT

#define GUI_FONT_NORMAL		PuristaMedium
#define GUI_FONT_BOLD		PuristaSemibold
#define GUI_FONT_MONO		EtelkaMonospaceProBold
#define GUI_FONT_SMALL		PuristaMedium
#define GUI_FONT_THIN		PuristaLight
#define GUI_BCG_RGB_R		"(profileNamespace getvariable ['GUI_BCG_RGB_R',0.6784])"
#define GUI_BCG_RGB_G		"(profileNamespace getvariable ['GUI_BCG_RGB_G',0.7490])"
#define GUI_BCG_RGB_B		"(profileNamespace getvariable ['GUI_BCG_RGB_B',0.5137])"
#define GUI_BCG_RGB_A		"(profileNamespace getvariable ['GUI_BCG_RGB_A',0.7000])"
#define GUI_BLU_RGB_R		"(profilenamespace getvariable ['Map_BLUFOR_R',0.0])"
#define GUI_BLU_RGB_G		"(profilenamespace getvariable ['Map_BLUFOR_G',0.8])"
#define GUI_BLU_RGB_B		"(profilenamespace getvariable ['Map_BLUFOR_B',1.0])"
#define GUI_BLU_RGB_A		"(profilenamespace getvariable ['Map_BLUFOR_A',0.8])"
#define GUI_OPF_RGB_R		"(profilenamespace getvariable ['Map_BLUFOR_R',0.0])"
#define GUI_OPF_RGB_G		"(profilenamespace getvariable ['Map_BLUFOR_G',1.0])"
#define GUI_OPF_RGB_B		"(profilenamespace getvariable ['Map_BLUFOR_B',1.0])"
#define GUI_OPF_RGB_A		"(profilenamespace getvariable ['Map_BLUFOR_A',0.8])"
#define GUI_IND_RGB_R		"(profilenamespace getvariable ['Map_BLUFOR_R',0.0])"
#define GUI_IND_RGB_G		"(profilenamespace getvariable ['Map_BLUFOR_G',1.0])"
#define GUI_IND_RGB_B		"(profilenamespace getvariable ['Map_BLUFOR_B',1.0])"
#define GUI_IND_RGB_A		"(profilenamespace getvariable ['Map_BLUFOR_A',0.8])"
#define BUTTON_SOUND_CLICK	{"\A3\ui_f\data\sound\onclick", 0.1, 1}
#define BUTTON_SOUND_ENTER	{"\A3\ui_f\data\sound\onover", 0.1, 1}
#define BUTTON_SOUND_ESCAP	{"\A3\ui_f\data\sound\onescape", 0.1, 1}
#define BUTTON_SOUND_BPUSH	{"\A3\ui_f\data\sound\new1", 0.1, 0}
#define SCROLL_ARROW_EMPTY	"\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"
#define SCROLL_ARROR_FULL	"\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"
#define SCROLL_BORDER		"\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"
#define SCROLL_THUMB		"\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"
#define COMBO_ARROW_EMPTY	"\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa"
#define COMBO_ARROW_FULL	"\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa"
#define ANIMTEXT_DEFAULT	"\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa"
#define ANIMTEXT_NORMAL		"\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa"
#define ANIMTEXT_DISABLED	"\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa"
#define ANIMTEXT_OVER		"\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa"
#define ANIMTEXT_FOCUS		"\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa"
#define ANIMTEXT_PRESS		"\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa"
#define ANIMTEXT_NOSHORT	"\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa"

class zumi_edit {
	idc = -1;
	type = 2;
	style = "16 + 512"; // multi line + no border
	x = 0;
	y = 0;
	h = 0.2;
	w = 1;
	font = "RobotoCondensed";
	sizeEx = 0.04;
	autocomplete = "";
	canModify = true;
	maxChars = 500;
	forceDrawCaret = false;
	colorSelection[] = {0,0,0.75,0.5};
	colorText[] = {0,0,0,1};
	colorDisabled[] = {1,0,0,1};
	colorBackground[] = {1,1,1,1};
	text = __EVAL("Line 1" + endl + "Line 2" + endl + "Line 3"); // how to output multiline
};

class IGUIBack
{
	type = 0;
	idc = 124;
	style = 128;
	text = "";
	colorText[] =
	{
		0,
		0,
		0,
		0
	};
	font = "RobotoCondensed";
	sizeEx = 0;
	shadow = 0;
	x = 0.1;
	y = 0.1;
	w = 0.1;
	h = 0.1;
	colorbackground[] =
	{
		"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])",
		"(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])",
		"(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])",
		"(profilenamespace getvariable ['IGUI_BCG_RGB_A',1])"
	};
};

class RscText
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = 0;
	idc = -1;
	colorBackground[] =
	{
		0,
		0,
		0,
		0
	};
	colorText[] =
	{
		1,
		1,
		1,
		1
	};
	text = "";
	fixedWidth = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0;
	shadow = 0;
	colorShadow[] =
	{
		0,
		0,
		0,
		0.5
	};
	font = "RobotoCondensed";
	SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	linespacing = 1;
	tooltipColorText[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorBox[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorShade[] =
	{
		0,
		0,
		0,
		0.65
	};
};

class RscListBox
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = 5;
	rowHeight = 0.1;
	colorText[] =
	{
		1,
		1,
		1,
		1
	};
	colorDisabled[] =
	{
		1,
		1,
		1,
		0.25
	};
	colorScrollbar[] =
	{
		1,
		0,
		0,
		0
	};
	colorSelect[] =
	{
		0,
		0,
		0,
		1
	};
	colorSelect2[] =
	{
		0,
		0,
		0,
		1
	};
	colorSelectBackground[] =
	{
		0.95,
		0.95,
		0.95,
		1
	};
	colorSelectBackground2[] =
	{
		1,
		1,
		1,
		0.5
	};
	colorBackground[] =
	{
		0,
		0,
		0,
		0.3
	};
	soundSelect[] =
	{
		"\A3\ui_f\data\sound\RscListbox\soundSelect",
		0.09,
		1
	};
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	colorPicture[] =
	{
		1,
		1,
		1,
		1
	};
	colorPictureSelected[] =
	{
		1,
		1,
		1,
		1
	};
	colorPictureDisabled[] =
	{
		1,
		1,
		1,
		0.25
	};
	colorPictureRight[] =
	{
		1,
		1,
		1,
		1
	};
	colorPictureRightSelected[] =
	{
		1,
		1,
		1,
		1
	};
	colorPictureRightDisabled[] =
	{
		1,
		1,
		1,
		0.25
	};
	colorTextRight[] =
	{
		1,
		1,
		1,
		1
	};
	colorSelectRight[] =
	{
		0,
		0,
		0,
		1
	};
	colorSelect2Right[] =
	{
		0,
		0,
		0,
		1
	};
	tooltipColorText[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorBox[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorShade[] =
	{
		0,
		0,
		0,
		0.65
	};

	class ListScrollBar
	{
		color[] = {1,1,1,0.6};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		thumb = "#(argb,8,8,3)color(1,1,1,1)";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		border = "#(argb,8,8,3)color(1,1,1,1)";
		shadow = 0;
		autoScrollEnabled = 1;
	};
	x = 0;
	y = 0;
	w = 0.3;
	h = 0.3;
	style = 16;
	font = "RobotoCondensed";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = 0;
	colorShadow[] =
	{
		0,
		0,
		0,
		0.5
	};
	period = 1.2;
	maxHistoryDelay = 1;
};

class RscPicture
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = 0;
	idc = -1;
	style = 48;
	colorBackground[] =
	{
		0,
		0,
		0,
		0
	};
	colorText[] =
	{
		1,
		1,
		1,
		1
	};
	font = "TahomaB";
	sizeEx = 0;
	lineSpacing = 0;
	text = "";
	fixedWidth = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.2;
	h = 0.15;
	tooltipColorText[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorBox[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorShade[] =
	{
		0,
		0,
		0,
		0.65
	};
};

class RscStructuredText
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = 13;
	idc = -1;
	style = 0;
	colorText[] =
	{
		1,
		1,
		1,
		1
	};

	class Attributes
	{
		font = "RobotoCondensed";
		color = "#ffffff";
		colorLink = "#D09B43";
		align = "left";
		shadow = 1;
	};
	x = 0;
	y = 0;
	h = 0.035;
	w = 0.1;
	text = "";
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = 1;
};

//Zumi Dialoge
class RscFrame
{
	type = 0;
	idc = -1;
	style = ST_FRAME;
	shadow = 2;
	text = "";
	colorBackground[] = {0,0,0,0.3};//1
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackgroundDisabled[] = {0.5,0.6,0.4,0.5};
	colorBackgroundActive[] = {0.5,0.6,0.4,1};
	colorFocused[] = {1,1,1,0.5};
	colorShadow[] = {0,0,0,0.3};
	colorBorder[] = {1,1,1,1};
	font = "PuristaSemiBold";
	sizeEx = 0.04;
};


class Box
{
	type = CT_STATIC;
	idc = -1;
	style = ST_CENTER;
	shadow = 0;
	colorBackground[] = {0.285,0.341,0.219,1};
	colorText[] = {0,0,0,1};
	font = "PuristaSemiBold";
	sizeEx = 0.02;
};

class RscButton
{
	idc = -1;
	access = 0;
	type = CT_BUTTON;
	text = "";
	colorText[] ={0.5,0.25,0,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] = {0.5,0.6,0.4,0.8};
	colorBackgroundDisabled[] = {0.5,0.6,0.4,0.5};
	colorBackgroundActive[] = {0.5,0.6,0.4,1};
	colorFocused[] = {1,1,1,0.5};
	colorShadow[] = {0,0,0,0.3};
	colorBorder[] = {1,1,1,1};
	soundEnter[] = {"",0.2,1};
  soundPush[] = {"",0.2,1};
  soundClick[] = {"",0.2,1};
  soundEscape[] = {"",0.2,1};
	style = ST_LEFT;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	shadow = 1;
	font = "PuristaSemiBold";
	sizeEx = 0.03;
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0;
	offsetPressedY = 0;
	borderSize = 0;
};

class RscButton_Keypad
{
	idc = -1;
	access = 0;
	type = CT_BUTTON;
	text = "";
	colorText[] ={0,0,0,1};
	colorBackground[] = {0.75,0.75,0.75,1};
	colorBackgroundDisabled[] = {0.5,0.6,0.4,0.5};
	colorBackgroundActive[] = {0.5,0.6,0.4,1};
	colorDisabled[] =	{1,1,1,0.25};
	colorFocused[] = {1,1,1,0.5};
	colorShadow[] = {0,0,0,0.3};
	colorBorder[] = {0,0,0,1};
	soundEnter[] = {"",0.2,1};
  soundPush[] = {"",0.2,1};
  soundClick[] = {"",0.2,1};
  soundEscape[] = {"",0.2,1};
	style = ST_CENTER;
	shadow = 0;
	font = "PuristaSemiBold";
	sizeEx = 0.03;
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0;
	offsetPressedY = 0;
	borderSize = 0;
};

class ZumiActiveText {
	font = "RobotoCondensed";
	idc = -1;
	default = false;
	picture = "";
	shadow = 2;
	sizeEx = "( ( ( ( (safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);";
	soundClick[] = BUTTON_SOUND_CLICK;
	soundEnter[] = BUTTON_SOUND_ENTER;
	soundEscape[] = BUTTON_SOUND_ENTER;
	soundPush[] = BUTTON_SOUND_BPUSH;
	style = 48;
	type = 11;
};

class ZumiProgress {
	type = 8;
	style = 0;
	x = 0.344;
	y = 0.619;
	w = 0.313726;
	h = 0.0261438;
	shadow = 2;
	texture = "\A3\ui_f\data\GUI\RscCommon\RscProgress\progressbar_ca.paa";
	colorFrame[] = {0,0,0,1};
	colorBar[] = {0.5,0.6,0.4,1};
};

class zumi_blackscreen
{
	type = 0;
	style = 128;
	text = "";
	colorbackground[] =	{0,0,0,1};
};

class zumi_checkbox
{
	type = 7; // CT_CHECKBOXES
	x = 0.604062 * safezoneW + safezoneX;
	y = 0.334 * safezoneH + safezoneY;
	w = 0.05 * safezoneW;
	h = 0.319 * safezoneH;
	sizeEx = 0.015 * safezoneH;
	font = "RobotoCondensed";
	style = 2;
	colorSelectedBg[] = {0, 0, 0, 0};
	colorText[] = {0.75, 0, 1};
	colorTextSelect[] = {0, 0.75, 0, 1};
	colorBackground[] = {1, 1, 1, 1};
	columns = 2;
	rows = 6;
};

class zumi_slider {
  idc = -1;
  type = 3;
  style = SL_HORZ;
  x = 0.4;
  y = 0.2;
  w = 0.3;
  h = 0.025;
  color[] = { 1, 1, 1, 1 };
  coloractive[] = { 1, 0, 0, 0.5 };
  // This is an ctrlEventHandler to show you some response if you move the sliderpointer.
  onSliderPosChanged = "hint format[""%1"",_this];";
  sliderPosition = 0;//Initial position when slider is created
	sliderRange[] = {0,120};//Min and max value of the slider
	sliderStep = 1;//Size of step when dragging
	vspacing = 120;
};


/*

	GUIs

*/

//Schnelle Waffenkammer
class waka_dialog {
	idd=1130;
	movingenable=false;
	onload = "[] spawn zumi_fnc_waka_anzeigen;";
	class controls {
		class waka_mainframe: RscFrame {
			idc = 1131;
			text = "";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			//w = 0.8225 * safezoneW;
			w = 0.4125 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class waka_hintergrund: IGUIBack {
			idc = 1132;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			//w = 0.8225 * safezoneW;
			w = 0.4125 * safezoneW;
			h = 0.55 * safezoneH;
			colorBackground[] = {0.267,0.4,0.267,1};
		};
		class waka_titel: RscText {
			idc = 1133;
			text = "Fast Armory (by Zumi)";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.215 * safezoneH + safezoneY;
			w = 0.392635 * safezoneW;
			h = 0.066 * safezoneH;
			colorText[] = {0,0,0,1};
			sizeEx = 0.025 * safezoneH;
		};
		class waka_kategorien_titel: RscText {
			idc = 1134;
			text = "Categories";
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.290 * safezoneH + safezoneY;
			w = 0.105 * safezoneW;
			h = 0.033 * safezoneH;
			sizeEx = 0.025 * safezoneH;
		};
		class waka_auswahl_titel: RscText {
			idc = 1135;
			text = "Items list";
			x = 0.416875 * safezoneW + safezoneX;
			y = 0.290 * safezoneH + safezoneY;
			w = 0.2803125 * safezoneW;
			h = 0.033 * safezoneH;
			sizeEx = 0.025 * safezoneH;
		};
		class waka_loadouts: RscListbox {
			idc = 1137;
			x = 0.416875 * safezoneW + safezoneX;
			y = 0.334 * safezoneH + safezoneY;
			w = 0.2803125 * safezoneW;
			h = 0.319 * safezoneH;
			sizeEx = 0.01875 * safezoneH;
			onLBSelChanged = "";
			onLBDblClick = "[] call zumi_fnc_waka_aufroedeln;";
			rowHeight = 0.1;
			period = 1;
			class ListScrollBar {
				color[] = {1,1,1,0.6};
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
			};
		};
		class waka_kategorien: RscListbox {
			idc = 1136;
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.334 * safezoneH + safezoneY;
			w = 0.105 * safezoneW;
			h = 0.319 * safezoneH;
			sizeEx = 0.01875 * safezoneH;
			onLBSelChanged = "[] call zumi_fnc_waka_updaten;";
			rowHeight = 0.1;
			period = 1;
			class ListScrollBar	{
				color[] = {1,1,1,0.6};
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
			};
		};
	};
};


//GUI JIP
class jip_dialog
{
	idd=5500;
	movingenable=false;
	onload = "";
	onUnload = "";
	class controls
	{
		class jip_hintergrund: IGUIBack
		{
			idc = 5501;
			x = 0.363515 * safezoneW + safezoneX;
			y = 0.338821 * safezoneH + safezoneY;
			w = 0.27324 * safezoneW;
			h = 0.188078 * safezoneH;
			colorBackground[] = {0.267,0.4,0.267,1};
		};
		class jip_rahmen: RscFrame
		{
			idc = 5502;
			text = "Wähle deine Spawnweise";
			sizeEx = 0.025 * safezoneH;
			x = 0.363515 * safezoneW + safezoneX;
			y = 0.338821 * safezoneH + safezoneY;
			w = 0.27324 * safezoneW;
			h = 0.188078 * safezoneH;
		};
		class jip_ja_1: RscButton_Keypad
		{
			idc = 5503;
			x = 0.372194 * safezoneW + safezoneX;
			y = 0.419126 * safezoneH + safezoneY;
			w = 0.0775638 * safezoneW;
			h = 0.0677085 * safezoneH;
			text = "Beam me up, Scotty!";
			tooltip = "Deine letzte gespeicherte Position und deine alte Ausrüstung werden geladen";
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
			action = "closeDialog 0; [0, 2] call zumi_fnc_persistent_join;";
		};
		class jip_ja_2: RscButton_Keypad
		{
			idc = 5504;
			x = 0.460338 * safezoneW + safezoneX;
			y = 0.419126 * safezoneH + safezoneY;
			w = 0.0775638 * safezoneW;
			h = 0.0677085 * safezoneH;
			text = "Zurück ins HQ";
			tooltip = "Dein gewählte Rolle wird überschrieben: Du spawnst mit deiner alten Ausrüstung im Hauptquartier";
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
			action = "closeDialog 0; [0, 1] call zumi_fnc_persistent_join;";
		};
		class jip_nein: RscButton_Keypad
		{
			idc = 5504;
			x = 0.548482 * safezoneW + safezoneX;
			y = 0.419126 * safezoneH + safezoneY;
			w = 0.0775638 * safezoneW;
			h = 0.0677085 * safezoneH;
			text = "Neueinstieg";
			tooltip = "Du spawnst frisch und grün hinter den Ohren im Hauptquartier mit der ausgewählten Rolle";
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
			action = "closeDialog 0; [] call zumi_fnc_new_join;";
		};
	};
};


//GUI Fuhrpark

class fuhrpark_dialog {
	idd=2018;
	movingenable=false;
	onload = "[] spawn zumi_fnc_fuhrpark_gui_anzeigen;";
	onUnload = "";
	class controls
	{
		class fuhrpark_rahmen: RscFrame	{
			idc = 1800;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.528 * safezoneH;
			text = "";
		};
		class fuhrpark_hintergrund: IGUIBack	{
			idc = 2200;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.528 * safezoneH;
			colorBackground[] = {0.267,0.4,0.267,1};
		};
		class fuhrpark_titel: RscText	{
			idc = 886;
			text = "Vehicle Management";
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.055 * safezoneH;
			colorText[] = {0,0,0,1};
			sizeEx = 0.025 * safezoneH;
		};
		class fuhrpark_liste: RscListbox	{
			idc = 447;
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.429 * safezoneH;
			sizeEx = 0.0125 * safezoneH;
			onLBSelChanged = "[] call zumi_fnc_fuhrpark_gui_updaten;";
			rowHeight = 0.1;
			period = 1;//Test
			class ListScrollBar	{
				color[] = {1,1,1,0.6};
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
			};
		};
		class fuhrpark_verwaltet: RscText {
			idc = 785;
			text = "Managed by:";
			x = 0.57 * safezoneW + safezoneX;
			y = 0.48 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.055 * safezoneH;
			sizeEx = 0.025 * safezoneH;
		};
		class fuhrpark_signatur: RscText {
			idc = 786;
			text = "Nobody";
			x = 0.57 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.055 * safezoneH;
			sizeEx = 0.025 * safezoneH;
		};
		class fuhrpark_wann: RscText {
			idc = 787;
			text = "Never";
			x = 0.57 * safezoneW + safezoneX;
			y = 0.56 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.055 * safezoneH;
			sizeEx = 0.025 * safezoneH;
		};
		class fuhrpark_spawn: RscButton	{
			idc = 1602;
			text = "Spawn selected";
			x = 0.613437 * safezoneW + safezoneX;
			y = 0.698 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.033 * safezoneH;
			action = "";
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltip = "This window will just close if the spawn is blocked by something";
		};
		class fuhrpark_despawn: RscButton	{
			idc = 1604;
			text = "Despawn selected";
			x = 0.613437 * safezoneW + safezoneX;
			y = 0.663 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.033 * safezoneH;
			action = "closeDialog 0; [player] remoteExecCall ['zumi_fnc_fuhrpark_vehikel_speichern', 2];";
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *  0.75)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltip = "The Ace-Inventory will be emptied first";
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
		class fuhrpark_pic: RscPicture {
			idc = 1605;
			text = "";
			x = 0.57 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.118992 * safezoneW;
			h = 0.159867 * safezoneH;
		};
		class fuhrpark_info: RscButton	{
			idc = 1601;
			text = "Ping Vehicle";
			x = 0.613437 * safezoneW + safezoneX;
			y = 0.628 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.033 * safezoneH;
			action = "";
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *  0.75)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltip = "Returns information about the vehicles position and its current key owners";
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
	};
};


class keypad_dialog {
	idd=2999;
	movingenable=false;
	onload = "";
	class controls {
		class keypad_hintergrund: IGUIBack
		{
			idc = 3000;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.286 * safezoneH;
			colorBackground[] = {0.6,0.6,0.6,1};
		};
		class keypad_frame: RscFrame
		{
			idc = 3001;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.286 * safezoneH;
			text = "Code eingeben";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			colorBackground[] = {0.6,0.6,0.6,1};
		};
		class keypad_monitor: RscText	{
			idc = 3002;
			x = 0.391719 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.033 * safezoneH;
			style = ST_CENTER + ST_SINGLE;
			text = "";
			colorText[] = {0,0,0,1};
			colorBackground[] = {0.75,0.75,0.75,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class keypad_1: RscButton_Keypad
		{
			idc = 3003;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.033 * safezoneH;
			text = "1";
			action = "[1] call zumi_fnc_keypad_updaten;";
		};
		class keypad_2: RscButton_Keypad
		{
			idc = 3004;
			x = 0.432969 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.033 * safezoneH;
			text = "2";
			action = "[2] call zumi_fnc_keypad_updaten;";
		};
		class keypad_3: RscButton_Keypad
		{
			idc = 3005;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.033 * safezoneH;
			text = "3";
			action = "[3] call zumi_fnc_keypad_updaten;";
		};
		class keypad_4: RscButton_Keypad
		{
			idc = 3006;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.033 * safezoneH;
			text = "4";
			action = "[4] call zumi_fnc_keypad_updaten;";
		};
		class keypad_5: RscButton_Keypad
		{
			idc = 3007;
			x = 0.432969 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.033 * safezoneH;
			text = "5";
			action = "[5] call zumi_fnc_keypad_updaten;";
		};
		class keypad_6: RscButton_Keypad
		{
			idc = 3008;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.033 * safezoneH;
			text = "6";
			action = "[6] call zumi_fnc_keypad_updaten;";
		};
		class keypad_7: RscButton_Keypad
		{
			idc = 3009;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.033 * safezoneH;
			text = "7";
			action = "[7] call zumi_fnc_keypad_updaten;";
		};
		class keypad_8: RscButton_Keypad
		{
			idc = 3010;
			x = 0.432969 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.033 * safezoneH;
			text = "8";
			action = "[8] call zumi_fnc_keypad_updaten;";
		};
		class keypad_9: RscButton_Keypad
		{
			idc = 3011;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.033 * safezoneH;
			text = "9";
			action = "[9] call zumi_fnc_keypad_updaten;";
		};
		class keypad_0: RscButton_Keypad
		{
			idc = 3012;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.033 * safezoneH;
			text = "0";
			action = "[0] call zumi_fnc_keypad_updaten;";
		};
		class keypad_corr: RscButton_Keypad
		{
			idc = 3013;
			x = 0.432969 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.033 * safezoneH;
			text = "CORR";
			action = "['corr'] call zumi_fnc_keypad_updaten;";
		};
		class keypad_enter: RscButton_Keypad
		{
			idc = 3014;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.033 * safezoneH;
			text = "ENTER";
			action = "closeDialog 0;";
		};
		class keypad_red: RscFrame
		{
			idc = 3015;
			x = 0.484531 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0103125 * safezoneW;
			h = 0.0055 * safezoneH;
		};
		class keypad_green: RscFrame
		{
			idc = 3016;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0103125 * safezoneW;
			h = 0.0055 * safezoneH;
		};
	};
};



class whitelist_dialog {
	idd=2310;
	movingenable=false;
	onload = "[] spawn zumi_fnc_whitelist_anzeigen;";
	class controls {
		class whitelist_hintergrund: IGUIBack {
			idc = -1;
			x = 0.323716 * safezoneW + safezoneX;
			y = 0.264902 * safezoneH + safezoneY;
			w = 0.352567 * safezoneW;
			h = 0.470196 * safezoneH;
			colorBackground[] = {0.267,0.4,0.267,1};
		};
		class whitelist_Frame: RscFrame {
			idc = -1;
			sizeEx = 0.025 * safezoneH;
			text = "Whitelistverwaltung";
			x = 0.323716 * safezoneW + safezoneX;
			y = 0.264902 * safezoneH + safezoneY;
			w = 0.352567 * safezoneW;
			h = 0.470196 * safezoneH;
		};
		class whitelist_spielerliste: RscListbox {
			idc = 2311;
			text = "Spielerliste";
			x = 0.328123 * safezoneW + safezoneX;
			y = 0.330729 * safezoneH + safezoneY;
			w = 0.110177 * safezoneW;
			h = 0.394965 * safezoneH;
			style = LB_SINGLE;
			sizeEx = 0.025 * safezoneH;
			onLBSelChanged = "[] call zumi_fnc_whitelist_updaten;";
			rowHeight = 0.1;
			period = 1;//Test
			class ListScrollBar	{
				color[] = {1,1,1,0.6};
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
			};
		};
		class whitelist_keys: RscButton {
			idc = 2313;
			text = "Fahrzeugschlüssel abgeben";
			x = 0.522035 * safezoneW + safezoneX;
			y = 0.678675 * safezoneH + safezoneY;
			w = 0.149841 * safezoneW;
			h = 0.0470196 * safezoneH;
			tooltip = "Gebe Ace-Fahrzeugschlüssel für angewählte Fahrzeuge aus";
			action = "";
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *  0.75)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
		class whitelist_fzg_liste: RscListbox {
			idc = 2312;
			onLBSelChanged = "[true] call zumi_fnc_whitelistbuttons_updaten;";
			text = "Fahrzeuge";
			Style = LB_MULTI;
			x = 0.442708 * safezoneW + safezoneX;
			y = 0.330729 * safezoneH + safezoneY;
			w = 0.0749206 * safezoneW;
			h = 0.394965 * safezoneH;
			sizeEx = 0.01 * safezoneH;
			rowHeight = 0.1;
			period = 1;//Test
			class ListScrollBar	{
				color[] = {1,1,1,0.6};
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
			};
			tooltip = "Fahrzeugnummern";
		};
		class whitelist_pz: RscButton {
			idc = 2314;
			text = "Panzerbesatzungsrecht";
			x = 0.522035 * safezoneW + safezoneX;
			y = 0.565828 * safezoneH + safezoneY;
			w = 0.149841 * safezoneW;
			h = 0.0470196 * safezoneH;
			tooltip = "Spieler darf Panzer nutzen";
			action = "";
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *  0.75)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
		class whitelist_eod: RscButton {
			idc = 2315;
			text = "Kampfmittelspezialist";
			x = 0.522035 * safezoneW + safezoneX;
			y = 0.45298 * safezoneH + safezoneY;
			w = 0.149841 * safezoneW;
			h = 0.0470196 * safezoneH;
			tooltip = "Spieler kann Sprengmittel entschärfen";
			action = "";
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *  0.75)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
		class whitelist_cfr_c: RscButton {
			idc = 2316;
			text = "CFR Charlie";
			x = 0.627806 * safezoneW + safezoneX;
			y = 0.340133 * safezoneH + safezoneY;
			w = 0.0440709 * safezoneW;
			h = 0.0470196 * safezoneH;
			tooltip = "Spieler hat höhere Chance, Patienten wiederzubeleben";
			action = "";
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *  0.75)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
		class whitelist_cfr_b: RscButton {
			idc = 2317;
			text = "CFR Bravo";
			x = 0.574921 * safezoneW + safezoneX;
			y = 0.340133 * safezoneH + safezoneY;
			w = 0.048478 * safezoneW;
			h = 0.0470196 * safezoneH;
			tooltip = "Spieler kann nähen";
			action = "";
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *  0.75)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
		class whitelist_cfr_a: RscButton {
			idc = 2318;
			text = "CFR Alpha";
			x = 0.522035 * safezoneW + safezoneX;
			y = 0.340133 * safezoneH + safezoneY;
			w = 0.048478 * safezoneW;
			h = 0.0470196 * safezoneH;
			tooltip = "Spieler zurücksetzen";
			action = "";
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *  0.75)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
		class whitelist_pio_0: RscButton {
			idc = 2319;
			text = "Pio 0";
			x = 0.522035 * safezoneW + safezoneX;
			y = 0.396557 * safezoneH + safezoneY;
			w = 0.048478 * safezoneW;
			h = 0.0470196 * safezoneH;
			tooltip = "Reparatur bis zu einem gewissen Wert";
			action = "";
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *  0.75)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
		class whitelist_pio_2: RscButton {
			idc = 2320;
			text = "Pio 2";
			x = 0.627806 * safezoneW + safezoneX;
			y = 0.396557 * safezoneH + safezoneY;
			w = 0.0440709 * safezoneW;
			h = 0.0470196 * safezoneH;
			tooltip = "Reparatur bis zu einem gewissen Wert";
			action = "";
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *  0.75)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
		class whitelist_pio_1: RscButton {
			idc = 2321;
			text = "Pio 1";
			x = 0.574921 * safezoneW + safezoneX;
			y = 0.396557 * safezoneH + safezoneY;
			w = 0.048478 * safezoneW;
			h = 0.0470196 * safezoneH;
			tooltip = "Reparatur bis zu einem gewissen Wert";
			action = "";
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *  0.75)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
		class whitelist_pilot_0: RscButton {
			idc = 2322;
			text = "Pilot 0";
			x = 0.522035 * safezoneW + safezoneX;
			y = 0.622251 * safezoneH + safezoneY;
			w = 0.048478 * safezoneW;
			h = 0.0470196 * safezoneH;
			tooltip = "Kann nicht fliegen";
			action = "";
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *  0.75)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
		class whitelist_pilot_1: RscButton {
			idc = 2323;
			text = "Pilot 1";
			x = 0.574921 * safezoneW + safezoneX;
			y = 0.622251 * safezoneH + safezoneY;
			w = 0.048478 * safezoneW;
			h = 0.0470196 * safezoneH;
			tooltip = "Kann Drehflügler fliegen";
			action = "";
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *  0.75)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
		class whitelist_pilot_2: RscButton {
			idc = 2324;
			text = "Pilot 2";
			x = 0.627806 * safezoneW + safezoneX;
			y = 0.622251 * safezoneH + safezoneY;
			w = 0.0440709 * safezoneW;
			h = 0.0470196 * safezoneH;
			tooltip = "Kann Starrflügler fliegen";
			action = "";
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *  0.75)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
		class whitelist_logi: RscButton {
			idc = 2325;
			text = "Logistikerberechtigung";
			x = 0.522035 * safezoneW + safezoneX;
			y = 0.509404 * safezoneH + safezoneY;
			w = 0.149841 * safezoneW;
			h = 0.0470196 * safezoneH;
			tooltip = "Spieler darf den Fuhrpark verwalten";
			action = "";
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *  0.75)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
	};
};


class memo_dialog {
	idd=1348;
	movingenable=true;
	onload = "[] spawn zumi_fnc_memo_gui_anzeigen;";
	class controls {
		class notizen_hintergrund: IGUIBack {
			idc = -1;
			x = 0.323716 * safezoneW + safezoneX;
			y = 0.264902 * safezoneH + safezoneY;
			w = 0.352567 * safezoneW;
			h = 0.470196 * safezoneH;
			colorBackground[] = {0.267,0.4,0.267,1};
		};
		class notizen_Frame: RscFrame {
			idc = -1;
			sizeEx = 0.025 * safezoneH;
			text = "Kompaniebefehle";
			x = 0.323716 * safezoneW + safezoneX;
			y = 0.264902 * safezoneH + safezoneY;
			w = 0.352567 * safezoneW;
			h = 0.470196 * safezoneH;
		};
		class notizen_block: zumi_edit {
			idc = 1349;
			sizeEx = 0.025 * safezoneH;
			text = "";
			maxChars = 1165;
			x = 0.323716 * safezoneW + safezoneX;
			y = 0.321325 * safezoneH + safezoneY;
			w = 0.352567 * safezoneW;
			h = 0.413773 * safezoneH;
		};
		class notizen_button: RscButton {
			idc = 1350;
			tooltip = "Änderungen speichern und Schliessen";
			action = "[] call zumi_fnc_memo_updaten;";
			x = 0.645434 * safezoneW + safezoneX;
			y = 0.264902 * safezoneH + safezoneY;
			w = 0.0308496 * safezoneW;
			h = 0.0470196 * safezoneH;
			text = "Save + Exit";
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,1};
			colorBackgroundDisabled[] = {0,0,0,1};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *  0.75)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
	};
};


class lagerverwaltung_dialog
{
	idd=2020;
	movingenable=false;
	onload = "[] spawn zumi_fnc_logistik_gui_anzeigen;";
	onUnload = "";
	class controls
	{
		class lagerverwaltung_mainframe: RscFrame
		{
			idc = 1801;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class lagerverwaltung_hintergrund: IGUIBack
		{
			idc = 2201;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.55 * safezoneH;
			colorBackground[] = {0.267,0.4,0.267,1};
		};
		class lagerverwaltung_titel: RscText
		{
			idc = 2202;
			text = "Storage management";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.215 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.066 * safezoneH;
			colorText[] = {0,0,0,1};
			sizeEx = 0.025 * safezoneH;
		};
		class bestellmenu_titel: RscText
		{
			idc = 2203;
			text = "Order";
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.033 * safezoneH;
			sizeEx = 0.025 * safezoneH;
		};
		class lieferplan_titel: RscText
		{
			idc = 2204;
			text = "Delivery plan";
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.055 * safezoneW;
			h = 0.033 * safezoneH;
			sizeEx = 0.025 * safezoneH;
		};
		class archiv_titel: RscText
		{
			idc = 2205;
			text = "Archive";
			x = 0.634062 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
			sizeEx = 0.025 * safezoneH;
		};
		class lagerverwaltung_luftfracht: ZumiActiveText
		{
			idc = 1604;
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.35 * safezoneH + safezoneY;
			w = 0.075 * safezoneW;
			h = 0.075 * safezoneH;
			action = "closeDialog 0; createDialog 'bestellung_dialog';";
			color[] = {1,1,1,1};
			colorActive[] = {0,0,0,1};
			colorDisabled[] = {1,1,1,1};
			colorBackgroundDisabled[] = {1,1,1,1};
			colorBackgroundActive[] = {1,1,1,1};
			colorFocused[] = {0,0,0,1};
			default = false;
			sizeEx = 0.0125 * safezoneH;
			soundClick[] = BUTTON_SOUND_CLICK;
			soundEnter[] = BUTTON_SOUND_ENTER;
			soundEscape[] = BUTTON_SOUND_ENTER;
			soundPush[] = BUTTON_SOUND_BPUSH;
			text = "\rhsusf\addons\rhsusf_a2port_air\data\mapico\icon_c130j_CA.paa";
			tooltip = "Air Cargo";
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
		class lagerverwaltung_legende: RscText
		{
			idc = 1607;
			text = "Number / Date / Date of delivery";
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.226875 * safezoneW;
			h = 0.0319 * safezoneH;
			sizeEx = 0.025 * safezoneH;
		};
		class lagerverwaltung_lieferplan: RscListbox
		{
			idc = 1608;
			text = "Delivery Plan";
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.226875 * safezoneW;
			h = 0.319 * safezoneH;
			sizeEx = 0.0125 * safezoneH;
			onLBSelChanged = "[] call zumi_fnc_logistik_gui_updaten;";
			rowHeight = 0.1;
			period = 1;//Test
			class ListScrollBar
			{
				color[] = {1,1,1,0.6};
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
			};
		};
		class lagerverwaltung_archiv: RscListbox
		{
			idc = 1609;
			text = "Archive";
			x = 0.634062 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.319 * safezoneH;
			sizeEx = 0.0125 * safezoneH;
			onLBSelChanged = "";
			rowHeight = 0.1;
			period = 1;//Test
			class ListScrollBar
			{
				color[] = {1,1,1,0.6};
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
			};
		};
		class lagerverwaltung_abschreiben: RscButton
		{
			idc = 1610;
			text = "Report lost";
			x = 0.567031 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.033 * safezoneH;
			colorText[] = {0.8,0,0,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltip = "Report commodities lost";
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
		class lagerverwaltung_details: RscButton
		{
			idc = 1611;
			text = "Details";
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.033 * safezoneH;
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltip = "Examine ordered stuff";
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
		class lagerverwaltung_verzoegern: RscButton
		{
			idc = 1612;
			text = "Delay";
			x = 0.453594 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.033 * safezoneH;
			colorText[] = {0.85,0.85,0,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltip = "Liefertermin falls möglich einen Tag nach hinten verschieben";
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
		class lagerverwaltung_quittieren: RscButton
		{
			idc = 1613;
			text = "Confirm";
			x = 0.567031 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.033 * safezoneH;
			colorText[] = {0,0.8,0,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltip = "Confirm delivery";
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
		class lagerverwaltung_stornieren: RscButton
		{
			idc = 1614;
			text = "Cancel";
			x = 0.510312 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.033 * safezoneH;
			colorText[] = {0.85,0.4,0,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,0.5};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltip = "Cancel order";
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
	};
};


//Gui Bestellungsdialoge
class bestellung_dialog {
	idd=2021;
	movingenable=false;
	onload = "[] spawn zumi_fnc_lieferkategorien_anzeigen;";
	class controls
	{
		class bestellung_mainframe: RscFrame
		{
			idc = 1802;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class bestellung_hintergrund: IGUIBack
		{
			idc = 2207;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.55 * safezoneH;
			colorBackground[] = {0.267,0.4,0.267,1};
		};
		class bestellung_titel: RscText
		{
			idc = 2208;
			text = "Supply-Airdrop";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.215 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.066 * safezoneH;
			colorText[] = {0,0,0,1};
			sizeEx = 0.025 * safezoneH;
		};
		class bestellung_kategorie_titel: RscText
		{
			idc = 2209;
			text = "Categories";
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.290 * safezoneH + safezoneY;
			w = 0.105 * safezoneW;//0.09
			h = 0.033 * safezoneH;
			sizeEx = 0.025 * safezoneH;
		};
		class bestellung_liefereinheiten_titel: RscText
		{
			idc = 2210;
			text = "Units that can be orded";
			x = 0.416875 * safezoneW + safezoneX;
			y = 0.290 * safezoneH + safezoneY;
			w = 0.186875 * safezoneW;
			h = 0.033 * safezoneH;
			sizeEx = 0.025 * safezoneH;
		};
		class bestellung_bestellliste_titel: RscText
		{
			idc = 2211;
			text = "Shopping Bag";
			x = 0.604062 * safezoneW + safezoneX;
			y = 0.290 * safezoneH + safezoneY;
			w = 0.091875 * safezoneW;
			h = 0.033 * safezoneH;
			sizeEx = 0.025 * safezoneH;
		};
		class bestellung_einheiten: RscListbox
		{
			idc = 1616;
			text = "Units that can be ordered";
			x = 0.416875 * safezoneW + safezoneX;
			y = 0.334 * safezoneH + safezoneY;
			w = 0.186875 * safezoneW;
			h = 0.319 * safezoneH;
			sizeEx = 0.0125 * safezoneH;
			onLBSelChanged = "";
			onLBDblClick = "[] call zumi_fnc_zum_warenkorb;";
			rowHeight = 0.1;
			period = 1;
			class ListScrollBar
			{
				color[] = {1,1,1,0.6};
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
			};
		};
		class bestellung_kategorie: RscListbox
		{
			idc = 1617;
			text = "Categories";
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.334 * safezoneH + safezoneY;
			w = 0.105 * safezoneW;//0.09
			h = 0.319 * safezoneH;
			sizeEx = 0.0125 * safezoneH;
			onLBSelChanged = "[] call zumi_fnc_liefereinheiten_updaten;";
			rowHeight = 0.1;
			period = 1;
			class ListScrollBar
			{
				color[] = {1,1,1,0.6};
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
			};
		};
		class bestellung_warenkorb: RscListbox
		{
			idc = 1618;
			text = "Ordered units";
			x = 0.604062 * safezoneW + safezoneX;
			y = 0.334 * safezoneH + safezoneY;
			w = 0.091875 * safezoneW;
			h = 0.319 * safezoneH;
			sizeEx = 0.0125 * safezoneH;
			onLBDblClick = "[(_this select 0), (_this select 1), true] call zumi_fnc_update_progressbar;";
			rowHeight = 0.1;
			period = 1;
			style = LB_MULTI;
			class ListScrollBar
			{
				color[] = {1,1,1,0.6};
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
			};
			tooltip = "Double-click to remove"; // Tooltip text
			tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
			tooltipColorText[] = {1,1,1,1}; // Tooltip text color
			tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color
		};
		class bestellung_warenkorb_bezahlen: RscButton
		{
			idc = 1619;
			text = "Order";
			x = 0.604062 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.091875 * safezoneW;
			h = 0.03 * safezoneH;
			action = "";
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorBackground[] = {0,0,0,1};
			colorBackgroundDisabled[] = {0,0,0,0.5};
			colorBackgroundActive[] = {0,0,0,1};
			colorFocused[] = {0,0,0,1};
			font = "RobotoCondensed";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			offsetX = 0;
			offsetY = 0;
			offsetPressedX = 0;
			offsetPressedY = 0;
			style = 2;
			tooltip = "Make order";
			tooltipColorBox[] = {1,1,1,1};
			tooltipColorShade[] = {0,0,0,1};
		};
		class bestellung_warenkorb_progress: ZumiProgress
		{
			idc = 1620;
			x = 0.35 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.03 * safezoneH;
		};
		class bestellung_progress_txt: rscText
		{
			idc = 1631;
			text = "Used cargo space: 0/20";
			style = ST_CENTER;
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			x = 0.35 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.03 * safezoneH;
		};
	};
};
