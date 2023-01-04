page 50054 "Job Maintenance List"
{
    CardPageID = "Repair & Maint. Job Card";
    Editable = false;
    PageType = List;
    SourceTable = 50016;

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
                field(Status; rec.Status)
                {
                }
                field("Vendor No."; rec."Vendor No.")
                {
                }
                field("Vendor Name"; rec."Vendor Name")
                {
                }
                field("Maintenance Type"; rec."Maintenance Type")
                {
                }
            }
        }
    }

    actions
    {
    }
}

