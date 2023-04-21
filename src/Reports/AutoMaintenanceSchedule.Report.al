report 50101 "Auto Maintenance Schedule"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Fixed Asset"; 5600)
        {
            DataItemTableView = WHERE(Inactive = CONST(false),
                                      Blocked = CONST(false));

            trigger OnAfterGetRecord()
            begin
                JobComponentHeader.RESET;
                JobComponentHeader.SETRANGE(JobComponentHeader."FA No.", "Fixed Asset"."No.");
                JobComponentHeader.SETRANGE(Blocked, FALSE);
                IF JobComponentHeader.FINDFIRST THEN
                    REPEAT
                        IF JobComponentHeader."Daily Job" THEN BEGIN
                            MaintenanceHeader.RESET;
                            MaintenanceHeader.SETRANGE(MaintenanceHeader."FA No.", JobComponentHeader."FA No.");
                            MaintenanceHeader.SETRANGE(MaintenanceHeader."Maintenance Type", JobComponentHeader."Maintenance Type");
                            MaintenanceHeader.SETRANGE(MaintenanceHeader."Creation Date", TODAY);
                            IF NOT MaintenanceHeader.FINDFIRST THEN BEGIN
                                MaintenanceHeader.INIT;
                                FASetup.GET;
                                FASetup.TESTFIELD(FASetup."Maintenance Nos.");
                                MaintenanceHeader."No." := NoSeriesMgt.GetNextNo(FASetup."Maintenance Nos.", WORKDATE, TRUE);
                                MaintenanceHeader."Created By" := USERID;
                                MaintenanceHeader."FA No." := "Fixed Asset"."No.";
                                MaintenanceHeader."FA Description" := "Fixed Asset".Description;
                                MaintenanceHeader.Component := JobComponentHeader.Component;
                                MaintenanceHeader."Sub-Component 1" := JobComponentHeader."Sub-Component 1";
                                MaintenanceHeader."Sub-Component 2" := JobComponentHeader."Sub-Component 2";
                                MaintenanceHeader."Creation Date" := TODAY;
                                MaintenanceHeader.Status := MaintenanceHeader.Status::"Under Maintenance";
                                MaintenanceHeader."Start Date" := TODAY;
                                MaintenanceHeader."End Date" := TODAY;
                                //MaintenanceHeader."Maintenance Type":=MaintenanceHeader."Maintenance Type"::"Maintenance Job";
                                MaintenanceHeader."Maintenance Type" := JobComponentHeader."Maintenance Type";
                                MaintenanceHeader.INSERT;
                                ComponentList.RESET;
                                ComponentList.SETRANGE(ComponentList."FA No.", MaintenanceHeader."FA No.");
                                ComponentList.SETRANGE(ComponentList.Period, JobComponentHeader.Period);
                                ComponentList.SETRANGE(ComponentList."Maintenance Type", JobComponentHeader."Maintenance Type");
                                IF ComponentList.FINDFIRST THEN
                                    REPEAT
                                        MaintenanceLine.RESET;
                                        MaintenanceLine.SETRANGE(MaintenanceLine."Document No.", MaintenanceHeader."No.");
                                        IF MaintenanceLine.FINDLAST THEN
                                            vlineno := MaintenanceLine."Line No." + 10000
                                        ELSE
                                            vlineno := 10000;
                                        MaintenanceLine.INIT;
                                        MaintenanceLine."Document No." := MaintenanceHeader."No.";
                                        MaintenanceLine."Line No." := vlineno;
                                        MaintenanceLine."Component Type" := ComponentList."Component Type";
                                        MaintenanceLine.VALIDATE(MaintenanceLine."Consumable Component", ComponentList.Component);
                                        MaintenanceLine.Quantity := ComponentList.Quantity;
                                        MaintenanceLine.INSERT;
                                    UNTIL ComponentList.NEXT = 0;
                            END;
                        END ELSE BEGIN
                            MaintenanceHeader.RESET;
                            MaintenanceHeader.SETRANGE(MaintenanceHeader."FA No.", JobComponentHeader."FA No.");
                            MaintenanceHeader.SETRANGE(MaintenanceHeader."Maintenance Type", JobComponentHeader."Maintenance Type");
                            MaintenanceHeader.SETRANGE(MaintenanceHeader."Creation Date", TODAY);
                            IF NOT MaintenanceHeader.FINDFIRST THEN BEGIN
                                CLEAR(vJobDate);
                                IF (JobComponentHeader."Next Job Date" = 0D) AND (JobComponentHeader."Creation Date" <> 0D) THEN
                                    vJobDate := CALCDATE(JobComponentHeader.Period, JobComponentHeader."Creation Date")
                                ELSE
                                    vJobDate := JobComponentHeader."Next Job Date";
                                IF vJobDate = TODAY THEN BEGIN
                                    JobComponentHeader."Next Job Date" := CALCDATE(JobComponentHeader.Period, vJobDate);
                                    JobComponentHeader.MODIFY;
                                    MaintenanceHeader.INIT;
                                    FASetup.GET;
                                    FASetup.TESTFIELD(FASetup."Maintenance Nos.");
                                    MaintenanceHeader."No." := NoSeriesMgt.GetNextNo(FASetup."Maintenance Nos.", WORKDATE, TRUE);
                                    MaintenanceHeader."Created By" := USERID;
                                    MaintenanceHeader."FA No." := "Fixed Asset"."No.";
                                    MaintenanceHeader.Component := JobComponentHeader.Component;
                                    MaintenanceHeader."Sub-Component 1" := JobComponentHeader."Sub-Component 1";
                                    MaintenanceHeader."Sub-Component 2" := JobComponentHeader."Sub-Component 2";
                                    MaintenanceHeader."FA Description" := "Fixed Asset".Description;
                                    MaintenanceHeader."Creation Date" := TODAY;
                                    MaintenanceHeader.Status := MaintenanceHeader.Status::"Under Maintenance";
                                    MaintenanceHeader."Start Date" := TODAY;
                                    MaintenanceHeader."End Date" := TODAY;
                                    //MaintenanceHeader."Maintenance Type":=JobComponentHeader."Maintenance Type"::"Maintenance Job";
                                    MaintenanceHeader."Maintenance Type" := JobComponentHeader."Maintenance Type";
                                    MaintenanceHeader.INSERT;
                                    ComponentList.RESET;
                                    ComponentList.SETRANGE(ComponentList."FA No.", MaintenanceHeader."FA No.");
                                    ComponentList.SETRANGE(ComponentList.Period, JobComponentHeader.Period);
                                    ComponentList.SETRANGE(ComponentList."Maintenance Type", JobComponentHeader."Maintenance Type");
                                    IF ComponentList.FINDFIRST THEN
                                        REPEAT
                                            MaintenanceLine.RESET;
                                            MaintenanceLine.SETRANGE(MaintenanceLine."Document No.", MaintenanceHeader."No.");
                                            IF MaintenanceLine.FINDLAST THEN
                                                vlineno := MaintenanceLine."Line No." + 10000
                                            ELSE
                                                vlineno := 10000;
                                            MaintenanceLine.INIT;
                                            MaintenanceLine."Document No." := MaintenanceHeader."No.";
                                            MaintenanceLine."Line No." := vlineno;
                                            MaintenanceLine."Component Type" := ComponentList."Component Type";
                                            MaintenanceLine.VALIDATE(MaintenanceLine."Consumable Component", ComponentList.Component);
                                            MaintenanceLine.Quantity := ComponentList.Quantity;
                                            MaintenanceLine.INSERT;
                                        UNTIL ComponentList.NEXT = 0;
                                END;
                            END;
                        END;
                    UNTIL JobComponentHeader.NEXT = 0;

                CLEAR(vQty);
                CLEAR(vPO);
                CLEAR(vUQty);
                MaintenanceHeader.RESET;
                //MaintenanceHeader.SETRANGE("FA No.",JobComponentHeader."FA No.");
                MaintenanceHeader.SETRANGE(MaintenanceHeader.Status, MaintenanceHeader.Status::"Under Maintenance");
                IF MaintenanceHeader.FINDFIRST THEN
                    REPEAT
                        MaintenanceLine.RESET;
                        MaintenanceLine.SETRANGE(MaintenanceLine."Document No.", MaintenanceHeader."No.");
                        IF MaintenanceLine.FINDFIRST THEN
                            REPEAT
                                IF MaintenanceLine."Component Type" = MaintenanceLine."Component Type"::Item THEN BEGIN
                                    MaintenanceLine.CALCFIELDS(MaintenanceLine."Quantity Utilized");
                                    vUQty := MaintenanceLine."Quantity Utilized";
                                    IF MaintenanceLine.Quantity = vUQty THEN BEGIN
                                        vQty := TRUE;
                                        vPO := TRUE;
                                    END;
                                END ELSE
                                    IF MaintenanceLine."Component Type" = MaintenanceLine."Component Type"::"G/L Account" THEN BEGIN
                                        IF MaintenanceHeader."Work Order No." <> '' THEN BEGIN
                                            vPO := TRUE;
                                            IF vQty THEN
                                                vQty := TRUE
                                            ELSE
                                                vQty := FALSE;
                                        END;
                                    END;
                            UNTIL MaintenanceLine.NEXT = 0;
                        IF (vQty) AND (vPO) THEN BEGIN
                            MaintenanceHeader.Status := MaintenanceHeader.Status::Close;
                            MaintenanceHeader.MODIFY;
                        END;
                        CLEAR(vQty);
                        CLEAR(vPO);
                        CLEAR(vUQty);
                    UNTIL MaintenanceHeader.NEXT = 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        JobComponentHeader: Record 50034;
        MaintenanceHeader: Record 50032;
        MaintenanceLine: Record 50033;
        vJobDate: Date;
        NoSeriesMgt: Codeunit 396;
        FASetup: Record 5603;
        ComponentList: Record 50036;
        vlineno: Integer;
        vSChDate: Date;
        vMainDate: Date;
        vQty: Boolean;
        vPO: Boolean;
        vUQty: Decimal;
}

