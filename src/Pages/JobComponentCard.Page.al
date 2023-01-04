page 50056 "Job Component Card"
{
    PageType = Card;
    SourceTable = 50036;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("FA No."; rec."FA No.")
                {
                }
                field("FA Description"; rec."FA Description")
                {
                }
                field(Component; rec.Component)
                {
                }
                field("Component Description"; rec."Component Description")
                {
                }
                field("Sub-Component 1"; rec."Sub-Component 1")
                {
                }
                field("Sub-Component 1 Description"; rec."Sub-Component 1 Description")
                {
                }
                field("Sub-Component 2"; rec."Sub-Component 2")
                {
                }
                field("Sub-Component 2 Description"; rec."Sub-Component 2 Description")
                {
                }
                field(Period; rec.Period)
                {
                }
                field(Blocked; rec.Blocked)
                {
                }
                field("Creation Date"; rec."Creation Date")
                {
                }
                field("Start Date"; rec."Start Date")
                {
                }
                field("End Date"; rec."End Date")
                {
                }
                field("Daily Job"; rec."Daily Job")
                {
                }
                field("Next Job Date"; rec."Next Job Date")
                {
                }
                field("Created By"; rec."Created By")
                {
                }
                field(Remarks; rec.Remarks)
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
            part(Control001; 50006)
            {
                SubPageLink = "FA No." = FIELD("FA No."),
                              Period = FIELD(Period),
                              "Maintenance Type" = FIELD("Maintenance Type");
            }
        }
    }

    actions
    {
    }
}

