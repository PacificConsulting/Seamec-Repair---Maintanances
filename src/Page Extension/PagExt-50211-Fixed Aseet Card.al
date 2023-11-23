pageextension 50211 "Fixed Asset Card" extends 5600
{
    layout
    {

    }

    actions
    {
        addafter("Ma&in Asset Statistics")
        {
            Action("Component List")
            {
                RunObject = Page "Job Component List";
                RunPageLink = "FA No." = FIELD("No.");
                ApplicationArea = All;
            }

            Action("Job List")
            {
                RunObject = Page "Job Maintenance List";
                RunPageLink = "FA No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }


    var
        myInt: Integer;
}