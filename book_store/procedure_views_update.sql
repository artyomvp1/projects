CREATE OR REPLACE PROCEDURE views_update
AS

BEGIN
    DBMS_MVIEW.REFRESH('vw_daily_sales') ;
    
    INSERT INTO event_log
        VALUES(event_log_sq.NEXTVAL, SYSTIMESTAMP, 'JOB', NULL, NULL, NULL, 'View VW_DAILY_SALES has been updated') ;
    
    COMMIT ;
END ;