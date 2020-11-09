/*

  Cleanupscript

*/

if !hasinterface exitWith {};


private _minX = 0;
private _maxX = 24;
private _minY = -1;
private _maxY = 35;

private _secondaryXAxisDistance = 1;
private _secondaryYAxisDistance = 1;

private _pointCount = 23;

private _size = 0.55;
private _width = _size * safezoneW;
private _height = _size * safezoneH * (getResolution#4);
private _left = 0.5 - _width/2; // centered
private _top = 0.5 - _height/2; // centered

private _colorBackground = [1,1,1,1];
private _colorAxis = [0.9,0.9,0.9,1];
private _colorCaption = [0,0,0,1];
private _colorCurve = [0.75,0,0,1];

// create display
"commy_graph" cutRsc ["RscTitleDisplayEmpty", "PLAIN", 0, false];
private _display = uiNamespace getVariable "RscTitleDisplayEmpty";

private _vignette = _display displayCtrl 1202;
_vignette ctrlShow false;

// create canvas
private _canvas = _display ctrlCreate ["RscMapControlEmpty", -1];
_canvas ctrlSetBackgroundColor [0,0,0,0];
_canvas ctrlSetPosition [_left, _top, _width, _height];
_canvas ctrlCommit 0;

// calc world coordinates
private _right = _left + _width;
private _bottom = _top + _height;

_canvas posScreenToWorld [_left, _top] params ["_mapLeft", "_mapTop"];
_canvas posScreenToWorld [_right, _bottom] params ["_mapRight", "_mapBottom"];

private _mapWidth = _mapRight - _mapLeft;
private _mapHeight = _mapTop - _mapBottom;
private _lineWidth = _mapHeight*.5/100; // 0.5% of canvas

// add draw script
private _rectangles = [];
_canvas setVariable ["commy_rectangles", _rectangles];
_canvas ctrlAddEventHandler ["Draw", {
  params ["_canvas"];

  {
      _x params ["_rectanglePos", "_rectangleWidth", "_rectangleHeight", "_rectangleAngle", "_rectangleColor"];

      _canvas drawRectangle [
          _rectanglePos,
          _rectangleWidth/2,
          _rectangleHeight/2,
          _rectangleAngle,
          _rectangleColor,
          "#(rgb,8,8,3)color(1,1,1,1)"
      ];
  } forEach (_canvas getVariable "commy_rectangles");
}];

// create background
_rectangles pushBack [
  [_mapLeft + _mapWidth/2, _mapTop - _mapHeight/2],
  _mapWidth,
  _mapHeight,
  0,
  _colorBackground
];

// axes
private _xOrigin = linearConversion [_minX, _maxX, 0, 0, _mapWidth];
private _yOrigin = linearConversion [_minY, _maxY, 0, 0, _mapHeight];

private _posOrigin = [_xOrigin, _yOrigin, 0] vectorAdd [_mapLeft, _mapBottom, 0];
_canvas posWorldToScreen _posOrigin params ["_posOriginLeft", "_posOriginTop"];

_rectangles pushBack [
  [_mapWidth/2, _yOrigin, 0] vectorAdd [_mapLeft, _mapBottom, 0],
  _mapWidth,
  _lineWidth,
  0,
  _colorAxis
];

_rectangles pushBack [
  [_xOrigin, _mapHeight/2, 0] vectorAdd [_mapLeft, _mapBottom, 0],
  _mapHeight,
  _lineWidth,
  90,
  _colorAxis
];

private _secondaryAxisLineWidth = _lineWidth/4;
private _captionWidth = _width/20;
private _captionHeight = _height/20;

private _text = _display ctrlCreate ["RscStructuredText", -1];
_text ctrlSetPosition [_posOriginLeft + 2, _posOriginTop, _captionWidth, _captionHeight];
_text ctrlCommit 0;
_text ctrlSetStructuredText text "0";
_text ctrlSetTextColor _colorCaption;

if (_secondaryYAxisDistance > 0) then {
  for "_y" from _secondaryYAxisDistance to _maxY step _secondaryYAxisDistance do {
      private _posY = linearConversion [_minY, _maxY, _y, 0, _mapHeight];
      private _pos = [_mapWidth/2, _posY, 0] vectorAdd [_mapLeft, _mapBottom, 0];

      _rectangles pushBack [
          _pos,
          _mapWidth,
          _secondaryAxisLineWidth,
          0,
          _colorAxis
      ];

      _canvas posWorldToScreen _pos params ["", "_posTop"];
      if (_posTop + _captionHeight < _bottom) then {
          private _text = _display ctrlCreate ["RscStructuredText", -1];

          _text ctrlSetPosition [_posOriginLeft, _posTop, _captionWidth, _captionHeight];
          _text ctrlCommit 0;
          _text ctrlSetStructuredText text str _y;
          _text ctrlSetTextColor _colorCaption;
      };
  };

  for "_y" from -_secondaryYAxisDistance to _minY step -_secondaryYAxisDistance do {
      private _posY = linearConversion [_minY, _maxY, _y, 0, _mapHeight];
      private _pos = [_mapWidth/2, _posY, 0] vectorAdd [_mapLeft, _mapBottom, 0];

      _rectangles pushBack [
          _pos,
          _mapWidth,
          _secondaryAxisLineWidth,
          0,
          _colorAxis
      ];

      _canvas posWorldToScreen _pos params ["", "_posTop"];
      if (_posTop + _captionHeight < _bottom) then {
          private _text = _display ctrlCreate ["RscStructuredText", -1];

          _text ctrlSetPosition [_posOriginLeft, _posTop, _captionWidth, _captionHeight];
          _text ctrlCommit 0;
          _text ctrlSetStructuredText text str _y;
          _text ctrlSetTextColor _colorCaption;
      };
  };
};

if (_secondaryXAxisDistance > 0) then {
  for "_x" from _secondaryXAxisDistance to _maxX step _secondaryXAxisDistance do {
      private _posX = linearConversion [_minX, _maxX, _x, 0, _mapWidth];
      private _pos = [_posX, _mapHeight/2, 0] vectorAdd [_mapLeft, _mapBottom, 0];

      _rectangles pushBack [
          _pos,
          _mapHeight,
          _secondaryAxisLineWidth,
          90,
          _colorAxis
      ];

      _canvas posWorldToScreen _pos params ["_posLeft"];
      if (_posLeft + _captionWidth < _right) then {
          private _text = _display ctrlCreate ["RscStructuredText", -1];

          _text ctrlSetPosition [_posLeft, _posOriginTop, _captionWidth, _captionHeight];
          _text ctrlCommit 0;
          _text ctrlSetStructuredText text str _x;
          _text ctrlSetTextColor _colorCaption;
      };
  };

  for "_x" from -_secondaryXAxisDistance to _minX step -_secondaryXAxisDistance do {
      private _posX = linearConversion [_minX, _maxX, _x, 0, _mapWidth];
      private _pos = [_posX, _mapHeight/2, 0] vectorAdd [_mapLeft, _mapBottom, 0];

      _rectangles pushBack [
          _pos,
          _mapHeight,
          _secondaryAxisLineWidth,
          90,
          _colorAxis
      ];

      _canvas posWorldToScreen _pos params ["_posLeft"];
      if (_posLeft + _captionWidth < _right) then {
          private _text = _display ctrlCreate ["RscStructuredText", -1];

          _text ctrlSetPosition [_posLeft, _posOriginTop, _captionWidth, _captionHeight];
          _text ctrlCommit 0;
          _text ctrlSetStructuredText text str _x;
          _text ctrlSetTextColor _colorCaption;
      };
  };
};

// create curve segments
private _previousX = 0;
private _previousY = 0;
private _deltaX = _maxX - _minX;

for "_i" from 0 to _pointCount do {
  private _x0 = _previousX;
  private _y0 = _previousY;
  private _x = _i;
  private _y = spielerstatistik select _i;
  //private _x = _minX + _deltaX * _i/_pointCount;
  //private _y = call _function;

  _previousX = _x;
  _previousY = _y;

  if (_i != 0 && {!isNil "_y"}) then {
      _x0 = linearConversion [_minX, _maxX, _x0, 0, _mapWidth];
      _x = linearConversion [_minX, _maxX, _x, 0, _mapWidth];
      _y0 = linearConversion [_minY, _maxY, _y0, 0, _mapHeight];
      _y = linearConversion [_minY, _maxY, _y, 0, _mapHeight];

      private _map1 = [_x0, _y0, 0];
      private _map2 = [_x, _y, 0];

      private _pos = (_map1 vectorAdd _map2) vectorMultiply .5 vectorAdd [_mapLeft, _mapBottom, 0];
      private _width = _map1 vectorDistance _map2;
      private _angle = ((_x - _x0) atan2 (_y - _y0)) + 90;

      _rectangles pushBack [
          _pos,
          _width,
          _lineWidth,
          _angle,
          _colorCurve
      ];
  };
};

"commy_graph" cutFadeOut 15;
