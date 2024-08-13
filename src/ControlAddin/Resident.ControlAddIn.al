/// <summary>
/// ControlAddIn Resident.
/// </summary>
controladdin Resident
{
    StartupScript = 'src\ControlAddIn\js\ResidentStartup.js';
    StyleSheets = 'src\ControlAddIn\css\Resident.css', 'src\ControlAddIn\css\ResidentDarkmode.css';

    RequestedHeight = 0;
    RequestedWidth = 0;
    VerticalStretch = false;
    HorizontalStretch = false;

    /// <summary>
    /// OnControlReady.
    /// </summary>
    event OnControlReady();

    /// <summary>
    /// OnGetPage.
    /// </summary>
    /// <param name="PageNo">Integer.</param>
    event OnGetPage(PageNo: Integer);

    /// <summary>
    /// StartListening.
    /// </summary>
    /// <param name="BaseURL">Text.</param>
    /// <param name="JsonObject">JsonObject.</param>
    procedure StartListening(BaseURL: Text; JsonObject: JsonObject);
}