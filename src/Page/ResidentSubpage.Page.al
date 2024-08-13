/// <summary>
/// Page Resident Subpage (ID 70101).
/// </summary>
page 70101 "Resident Subpage"
{
    PageType = CardPart;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            usercontrol(Resident; Resident)
            {
                ApplicationArea = All;

                trigger OnControlReady()
                var
                    ResidentSingleInstance: Codeunit "Resident Single Instance";
                begin
                    ResidentSingleInstance.SetControlAddin(CurrPage.Resident);
                    ResidentSingleInstance.SetInstantiated(true);
                    ResidentSingleInstance.UpdateControlAddin();
                end;

                trigger OnGetPage(PageNo: Integer)
                begin
                    Page.Run(PageNo);
                end;
            }
        }
    }

    trigger OnInit()
    begin
        if ResidentSingleInstance.GetControlAddinInstantiated() then
            ResidentSingleInstance.UpdateControlAddin();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        ResidentSingleInstance.SetInstantiated(false);
    end;

    var
        ResidentSingleInstance: Codeunit "Resident Single Instance";
}