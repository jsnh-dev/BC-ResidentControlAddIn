/// <summary>
/// Page Javascript Settings (ID 70100).
/// </summary>
page 70100 "Javascript Settings"
{
    PageType = StandardDialog;
    UsageCategory = None;
    SourceTable = "Javascript Settings";
    Caption = 'Javascript Settings';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(Darkmode; Rec.Darkmode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Activate darkmode for your BC environment.';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
    begin
        xJavascriptSettings := Rec;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = Action::Cancel then begin
            Rec.Darkmode := xJavascriptSettings.Darkmode;
            Rec.Modify(true);
        end;
    end;

    var
        xJavascriptSettings: Record "Javascript Settings";
}