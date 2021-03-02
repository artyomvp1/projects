BEGIN
    DBMS_SCHEDULER.CREATE_JOB (job_name             => 'job_update_views',
                               job_type             => 'PLSQL_BLOCK',
                               job_action           => 'BEGIN
                                                            DBMS_MVIEW.REFRESH(''vw_daily_sales'') ;
                                                            
                                                            INSERT INTO event_log
                                                                VALUES(event_log_sq.NEXTVAL, SYSTIMESTAMP, ''JOB'', NULL, NULL, NULL, ''View VW_DAILY_SALES has been updated'') ;
                                                            
                                                            COMMIT ;
                                                        END ;',
                               start_date           => SYSTIMESTAMP,
                               repeat_interval      => 'freq=daily; interval=1;', --hourly
                               end_date             => NULL,
                               enabled              => TRUE,
                               comments             => 'Job to update views') ;
END ;