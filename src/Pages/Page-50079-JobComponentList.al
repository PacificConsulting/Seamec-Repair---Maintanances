page 50079 "Job Component List"
{
    CardPageID = "Job Component Card";
    PageType = List;
    SourceTable = 50034;
    ApplicationArea = all;
    UsageCategory = lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("FA No."; rec."FA No.")
                {
                    Editable = false;
                }
                field("FA Description"; rec."FA Description")
                {
                    Editable = false;
                }
                field(Remarks; rec.Remarks)
                {
                    Editable = false;
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    Editable = false;
                }
                field("Vendor Name"; rec."Vendor Name")
                {
                    Editable = false;
                }
                field("Maintenance Type"; rec."Maintenance Type")
                {
                    Editable = false;
                }
                field(Period; rec.Period)
                {
                    Editable = false;
                }
                field(Blocked; rec.Blocked)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

