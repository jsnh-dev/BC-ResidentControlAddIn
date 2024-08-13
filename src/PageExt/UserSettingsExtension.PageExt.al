/// <summary>
/// PageExtension User Settings Extension (ID 70100) extends Record User Settings.
/// </summary>
pageextension 70100 "User Settings Extension" extends "User Settings"
{
    layout
    {
        addafter("Teaching Tips")
        {
            field(JavascriptSettings; JavascriptSettingsTxt)
            {
                ApplicationArea = All;
                Caption = 'Javascript Settings';
                ToolTip = 'Change the javascript settings.';
                Editable = false;

                trigger OnDrillDown()
                var
                    JavascriptSettingsRec: Record "Javascript Settings";
                begin
                    JavascriptSettingsRec.Get(UserSecurityId());

                    Page.RunModal(Page::"Javascript Settings", JavascriptSettingsRec);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        JavascriptSettingsRec: Record "Javascript Settings";
        JavascriptSettingsLbl: Label 'Change the javascript settings.';
    begin
        JavascriptSettingsTxt := JavascriptSettingsLbl;

        if not JavascriptSettingsRec.Get(UserSecurityId()) then begin
            JavascriptSettingsRec.Init();
            JavascriptSettingsRec."User Security Id" := UserSecurityId();
            JavascriptSettingsRec.Insert();
        end;
    end;

    var
        JavascriptSettingsTxt: Text;
}