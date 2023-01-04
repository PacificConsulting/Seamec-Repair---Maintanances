page 50028 "Repair & Maint. Job List"
{
    CardPageID = "Repair & Maint. Job Card";
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50016;
    SourceTableView = WHERE(Status = FILTER("Under Maintenance"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.")
                {
                }
                field("FA No."; rec."FA No.")
                {
                }
                field("FA Description"; rec."FA Description")
                {
                }
                field("Creation Date"; rec."Creation Date")
                {
                }
                field("Location Code"; rec."Location Code")
                {
                }
                field(Status; rec.Status)
                {
                }
                field("Description of the Problem"; rec."Description of the Problem")
                {
                }
            }
        }
    }

    actions
    {
    }
}

