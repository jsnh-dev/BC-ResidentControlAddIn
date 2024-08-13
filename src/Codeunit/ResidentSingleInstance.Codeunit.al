/// <summary>
/// Codeunit Resident Single Instance (ID 70100).
/// </summary>
codeunit 70100 "Resident Single Instance"
{
    SingleInstance = true;

    /// <summary>
    /// SetControlAddin.
    /// </summary>
    /// <param name="Resident2">ControlAddIn Resident.</param>
    procedure SetControlAddin(Resident2: ControlAddIn Resident)
    begin
        Resident := Resident2;
    end;

    /// <summary>
    /// UpdateControlAddin.
    /// </summary>
    procedure UpdateControlAddin()
    var
        JavascriptSettings: Record "Javascript Settings";
        JsonObject: JsonObject;
    begin
        JavascriptSettings.Get(UserSecurityId());

        JsonObject.Add('darkmode', JavascriptSettings.Darkmode);

        Resident.StartListening(GetUrl(ClientType::Web, CompanyName), JsonObject);
    end;

    /// <summary>
    /// SetInstantiated.
    /// </summary>
    /// <param name="Value">Boolean.</param>
    procedure SetInstantiated(Value: Boolean)
    begin
        Instantiated := Value;
    end;

    /// <summary>
    /// GetControlAddinInstantiated.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure GetControlAddinInstantiated(): Boolean
    begin
        exit(Instantiated);
    end;

    var
        Resident: ControlAddIn Resident;
        Instantiated: Boolean;

    /// <summary>
    /// OnAfterModifyJavascriptSettings.
    /// </summary>
    /// <param name="Rec">VAR Record "Javascript Settings".</param>
    /// <param name="xRec">VAR Record "Javascript Settings".</param>
    /// <param name="RunTrigger">Boolean.</param>

    [EventSubscriber(ObjectType::Table, Database::"Javascript Settings", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyJavascriptSettings(var Rec: Record "Javascript Settings"; var xRec: Record "Javascript Settings"; RunTrigger: Boolean)
    var
        ResidentSubpage: Page "Resident Subpage";
    begin
        ResidentSubpage.Update(false);
    end;
}