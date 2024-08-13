/// <summary>
/// PageExtension Business Manager R. C. Ext. (ID 70101) extends Record Business Manager Role Center.
/// </summary>
pageextension 70101 "Business Manager R. C. Ext." extends "Business Manager Role Center"
{
    layout
    {
        addafter(Control139)
        {
            part(Resident; "Resident Subpage")
            {
                ApplicationArea = All;
            }
        }
    }
}