page 50081 "Job Components"
{
    PageType = List;
    SourceTable = 50031;
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
                }
                field("Component Type"; rec."Component Type")
                {
                }
                field(Component; rec.Component)
                {
                }
                field(Quantity; rec.Quantity)
                {
                }
                field(Description; rec.Description)
                {
                }
                field(Period; rec.Period)
                {
                }
                field("Maintenance Type"; rec."Maintenance Type")
                {
                }
                field(Select; rec.Select)
                {
                }
            }
        }
    }

    actions
    {
    }
}

