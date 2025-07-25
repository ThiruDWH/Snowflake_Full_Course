

                     ====================================================================
                               UNLOADING DATA TO INTERNAL STAGE FROM SNOWFLAKE
--                   ====================================================================
                     
// Create file format object
CREATE OR REPLACE FILE FORMAT unload_ff
    type = csv
    field_delimiter = '|'
    skip_header = 0
    empty_field_as_null = TRUE;    
    
// creating stage
create or replace stage int_stage
file_format = unload_ff ;

// copying files into internal stage from snowflake table
copy into @int_stage/customer/
from customer_psv
overwrite=true
single=true 
detailed_output=true ;

// listing files in internal stage
list @int_stage;

drop stage int_stage;

// downloading file to local system by using GET command   
GET @int_stage/customer/data file://C:\Users\shivamkum\Videos\sky_files\unloading;
GET @int_stage/customer/data_0_0_0.csv.gz file://C:\Users\shivamkum\Videos\sky_files\unloading;


//downloading file from @%table stage    -- @% symbol for table stage
GET @%table_stage/customer/data file://C:\Users\shivamkum\Videos\sky_files\unloading;

//downloading file from @~user stage     --@~  for user stage
GET @~user_stage/customer/data file://C:\Users\shivamkum\Videos\sky_files\unloading;
