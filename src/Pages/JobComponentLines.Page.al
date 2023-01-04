page 50006 "Job Component Lines"
{
    PageType = ListPart;
    SourceTable = 50000;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Component Type"; rec."Component Type")
                {
                    ApplicationArea = all;
                }
                field(Component; rec.Component)
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

