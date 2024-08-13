/// <summary>
/// Table Javascript Settings (ID 70100).
/// </summary>
table 70100 "Javascript Settings"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "User Security Id"; Guid)
        {
            DataClassification = CustomerContent;
        }
        field(2; Darkmode; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "User Security Id")
        {
            Clustered = true;
        }
    }
}