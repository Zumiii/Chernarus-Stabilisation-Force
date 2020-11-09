params ["_handle","_status"];

private "_taskhinweis";


_taskhinweis = switch (tolower  _status) do {
	case "created" :	{
    "zumi_task_erstellt"
  };
	case "current" :	{
    "zumi_task_aktualisiert"
  };
	case "assigned" :	{
    "zumi_task_zugewiesen"
  };
	case "succeeded" :	{
    "zumi_task_erfolgreich"
  };
	case "failed" :		{
    "zumi_task_versagt"
  };
	case "canceled" :	{
    "zumi_task_abgebrochen"
  };
	case "updated" :	{
    "zumi_task_aktualisiert"
  };
	default {"zumi_task_erstellt"};
};

[
  _taskhinweis,
  [format ["%1",((taskDescription _handle) select 1)]]
] call bis_fnc_showNotification;
