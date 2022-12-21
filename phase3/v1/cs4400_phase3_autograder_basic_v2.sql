-- CS4400: Introduction to Database Systems (Fall 2022)
-- Project Phase III: Autograder ADVANCED [v0] Monday, Oct 31, 2022
set global transaction isolation level serializable;
set global SQL_MODE = 'ANSI,TRADITIONAL';
set names utf8mb4;
set SQL_SAFE_UPDATES = 0;

set @thisDatabase = 'restaurant_supply_express';
use restaurant_supply_express;
-- ----------------------------------------------------------------------------------
-- [1] Implement a capability to reset the database state easily
-- ----------------------------------------------------------------------------------

drop procedure if exists magic44_reset_database_state;
delimiter //
create procedure magic44_reset_database_state ()
begin
	-- Purge and then reload all of the database rows back into the tables.
    -- Ensure that the data is deleted in reverse order with respect to the
    -- foreign key dependencies (i.e., from children up to parents).
	delete from payload;
	delete from ingredients;
	delete from drones where flown_by is null;
	delete from drones;
	delete from work_for;
	delete from delivery_services;
	delete from pilots;
	delete from workers;
	delete from restaurants;
	delete from employees;
	delete from restaurant_owners;
	delete from locations;
	delete from users;

    -- Ensure that the data is inserted in order with respect to the
    -- foreign key dependencies (i.e., from parents down to children).
    insert into users values
	('jstone5', 'Jared', 'Stone', '101 Five Finger Way', '1961-01-06'),
	('sprince6', 'Sarah', 'Prince', '22 Peachtree Street', '1968-06-15'),
	('awilson5', 'Aaron', 'Wilson', '220 Peachtree Street', '1963-11-11'),
	('lrodriguez5', 'Lina', 'Rodriguez', '360 Corkscrew Circle', '1975-04-02'),
	('tmccall5', 'Trey', 'McCall', '360 Corkscrew Circle', '1973-03-19'),
	('eross10', 'Erica', 'Ross', '22 Peachtree Street', '1975-04-02'),
	('hstark16', 'Harmon', 'Stark', '53 Tanker Top Lane', '1971-10-27'),
	('echarles19', 'Ella', 'Charles', '22 Peachtree Street', '1974-05-06'),
	('csoares8', 'Claire', 'Soares', '706 Living Stone Way', '1965-09-03'),
	('agarcia7', 'Alejandro', 'Garcia', '710 Living Water Drive', '1966-10-29'),
	('bsummers4', 'Brie', 'Summers', '5105 Dragon Star Circle', '1976-02-09'),
	('cjordan5', 'Clark', 'Jordan', '77 Infinite Stars Road', '1966-06-05'),
	('fprefontaine6', 'Ford', 'Prefontaine', '10 Hitch Hikers Lane', '1961-01-28'),
	('mrobot1', 'Mister', 'Robot', '10 Autonomy Trace', '1988-11-02'),
	('mrobot2', 'Mister', 'Robot', '10 Clone Me Circle', '1988-11-02'),
	('ckann5', 'Carrot', 'Kann', '64 Knights Square Trail', '1972-09-01'),
	('rlopez6', 'Radish', 'Lopez', '8 Queens Route', '1999-09-03');

	insert into employees values
	('awilson5', '111-11-1111', '2020-03-15', 9, 46000),
	('lrodriguez5', '222-22-2222', '2019-04-15', 20, 58000),
	('tmccall5', '333-33-3333', '2018-10-17', 29, 33000),
	('eross10', '444-44-4444', '2020-04-17', 10, 61000),
	('hstark16', '555-55-5555', '2018-07-23', 20, 59000),
	('echarles19', '777-77-7777', '2021-01-02', 3, 27000),
	('csoares8', '888-88-8888', '2019-02-25', 26, 57000),
	('agarcia7', '999-99-9999', '2019-03-17', 24, 41000),
	('bsummers4', '000-00-0000', '2018-12-06', 17, 35000),
	('fprefontaine6', '121-21-2121', '2020-04-19', 5, 20000),
	('mrobot1', '101-01-0101', '2015-05-27', 8, 38000),
	('mrobot2', '010-10-1010', '2015-05-27', 8, 38000),
	('ckann5', '640-81-2357', '2019-08-03', 27, 46000),
	('rlopez6', '123-58-1321', '2017-02-05', 51, 64000);

	insert into restaurant_owners values
	('jstone5'), ('sprince6'), ('cjordan5');

	insert into pilots values
	('awilson5', '314159', 41), ('lrodriguez5', '287182', 67),
	('tmccall5', '181633', 10), ('agarcia7', '610623', 38),
	('bsummers4', '411911', 35), ('fprefontaine6', '657483', 2),
	('echarles19', '236001', 10), ('csoares8', '343563', 7),
	('mrobot1', '101010', 18), ('rlopez6', '235711', 58);

	insert into workers values
	('tmccall5'), ('eross10'), ('hstark16'), ('echarles19'),
	('csoares8'), ('mrobot2'), ('ckann5');

	insert into ingredients values
	('pr_3C6A9R', 'prosciutto', 6), ('ss_2D4E6L', 'saffron', 3),
	('hs_5E7L23M', 'truffles', 3), ('clc_4T9U25X', 'caviar', 5),
	('ap_9T25E36L', 'foie gras', 4), ('bv_4U5L7M', 'balsamic vinegar', 4);

	insert into locations values
	('plaza', 5, 12, 20), ('midtown', 1, 4, 3), ('highpoint', 7, 0, 2),
	('southside', 3, -6, 3), ('mercedes', 1, 1, 2), ('avalon', 2, 16, 5),
	('airport', -2, -9, 4), ('buckhead', 3, 8, 4);

	insert into restaurants values
	('Lure', 5, 20, 'midtown', 'jstone5'), ('Ecco', 3, 0, 'buckhead', 'jstone5'),
	('South City Kitchen', 5, 30, 'midtown', 'jstone5'), ('Tre Vele', 4, 10, 'plaza', null),
	('Fogo de Chao', 4, 30, 'buckhead', null), ('Hearth', 4, 0, 'avalon', null),
	('Il Giallo', 4, 10, 'mercedes', 'sprince6'), ('Bishoku', 5, 10, 'plaza', null),
	('Casi Cielo', 5, 30, 'plaza', null), ('Micks', 2, 0, 'southside', null);

	insert into delivery_services values
	('osf', 'On Safari Foods', 'southside', 'eross10'),
    ('hf', 'Herban Feast', 'southside', 'hstark16'),
	('rr', 'Ravishing Radish', 'avalon', 'echarles19');

	insert into drones values
	('osf', 1, 100, 9, 0, 'awilson5', null, null, 'airport'),
	('hf', 1, 100, 6, 0, 'fprefontaine6', null, null, 'southside'),
	('hf', 5, 27, 7, 100, 'fprefontaine6', null, null, 'buckhead'),
	('hf', 8, 100, 8, 0, 'bsummers4', null, null, 'southside'),
	('hf', 16, 17, 5, 40, 'fprefontaine6', null, null, 'buckhead'),
	('rr', 3, 100, 5, 50, 'agarcia7', null, null, 'avalon'),
	('rr', 7, 53, 5, 100, 'agarcia7', null, null, 'avalon'),
	('rr', 8, 100, 6, 0, 'agarcia7', null, null, 'highpoint');

	insert into drones values
	('osf', 2, 75, 7, 0, null, 'osf', 1, 'airport'),
	('hf', 11, 25, 10, 0, null, 'hf', 5, 'buckhead'),
	('rr', 11, 90, 6, 0, null, 'rr', 8, 'highpoint');

	insert into payload values
	('osf', 1, 'pr_3C6A9R', 5, 20),
	('osf', 1, 'ss_2D4E6L', 3, 23),
	('osf', 2, 'hs_5E7L23M', 7, 14),
	('hf', 1, 'ss_2D4E6L', 6, 27),
	('hf', 5, 'hs_5E7L23M', 4, 17),
	('hf', 5, 'clc_4T9U25X', 1, 30),
	('hf', 8, 'pr_3C6A9R', 4, 18),
	('hf', 11, 'ss_2D4E6L', 3, 19),
	('rr', 3, 'hs_5E7L23M', 2, 15),
	('rr', 3, 'clc_4T9U25X', 2, 28);

	insert into work_for values
	('eross10', 'osf'), ('hstark16', 'hf'), ('echarles19', 'rr'),
	('tmccall5', 'hf'), ('awilson5', 'osf'), ('fprefontaine6', 'hf'),
	('bsummers4', 'hf'), ('agarcia7', 'rr'), ('mrobot1', 'osf'),
	('mrobot1', 'rr'), ('ckann5', 'osf'), ('rlopez6', 'rr');
end //
delimiter ;

-- ----------------------------------------------------------------------------------
-- [2] Create views to evaluate the queries & transactions
-- ----------------------------------------------------------------------------------
    
-- Create one view per original base table and student-created view to be used
-- to evaluate the transaction results.
create or replace view practiceQuery10 as select * from users;
create or replace view practiceQuery11 as select * from restaurant_owners;
create or replace view practiceQuery12 as select * from employees;
create or replace view practiceQuery13 as select * from pilots;
create or replace view practiceQuery14 as select * from workers;
create or replace view practiceQuery15 as select * from ingredients;
create or replace view practiceQuery16 as select * from locations;
create or replace view practiceQuery17 as select * from restaurants;
create or replace view practiceQuery18 as select * from delivery_services;
create or replace view practiceQuery19 as select * from drones;
create or replace view practiceQuery20 as select * from payload;
create or replace view practiceQuery21 as select * from work_for;

create or replace view practiceQuery30 as select * from display_owner_view;
create or replace view practiceQuery31 as select * from display_employee_view;
create or replace view practiceQuery32 as select * from display_pilot_view;
create or replace view practiceQuery33 as select * from display_location_view;
create or replace view practiceQuery34 as select * from display_ingredient_view;
create or replace view practiceQuery35 as select * from display_service_view;

-- ----------------------------------------------------------------------------------
-- [3] Prepare to capture the query results for later analysis
-- ----------------------------------------------------------------------------------

-- The magic44_data_capture table is used to store the data created by the student's queries
-- The table is populated by the magic44_evaluate_queries stored procedure
-- The data in the table is used to populate the magic44_test_results table for analysis

drop table if exists magic44_data_capture;
create table magic44_data_capture (
	stepID integer, queryID integer,
    columnDump0 varchar(1000), columnDump1 varchar(1000), columnDump2 varchar(1000), columnDump3 varchar(1000), columnDump4 varchar(1000),
    columnDump5 varchar(1000), columnDump6 varchar(1000), columnDump7 varchar(1000), columnDump8 varchar(1000), columnDump9 varchar(1000),
	columnDump10 varchar(1000), columnDump11 varchar(1000), columnDump12 varchar(1000), columnDump13 varchar(1000), columnDump14 varchar(1000)
);

-- The magic44_column_listing table is used to help prepare the insert statements for the magic44_data_capture
-- table for the student's queries which may have variable numbers of columns (the table is prepopulated)

drop table if exists magic44_column_listing;
create table magic44_column_listing (
	columnPosition integer,
    simpleColumnName varchar(50),
    nullColumnName varchar(50)
);

insert into magic44_column_listing (columnPosition, simpleColumnName) values
(0, 'columnDump0'), (1, 'columnDump1'), (2, 'columnDump2'), (3, 'columnDump3'), (4, 'columnDump4'),
(5, 'columnDump5'), (6, 'columnDump6'), (7, 'columnDump7'), (8, 'columnDump8'), (9, 'columnDump9'),
(10, 'columnDump10'), (11, 'columnDump11'), (12, 'columnDump12'), (13, 'columnDump13'), (14, 'columnDump14');

drop function if exists magic44_gen_simple_template;
delimiter //
create function magic44_gen_simple_template(numberOfColumns integer)
	returns varchar(1000) reads sql data
begin
	return (select group_concat(simpleColumnName separator ', ') from magic44_column_listing
	where columnPosition < numberOfColumns);
end //
delimiter ;

-- Create a variable to effectively act as a program counter for the testing process/steps
set @stepCounter = 0;

-- The magic44_query_capture function is used to construct the instruction
-- that can be used to execute and store the results of a query

drop function if exists magic44_query_capture;
delimiter //
create function magic44_query_capture(thisQuery integer)
	returns varchar(1000) reads sql data
begin
	set @numberOfColumns = (select count(*) from information_schema.columns
		where table_schema = @thisDatabase
        and table_name = concat('practiceQuery', thisQuery));

	set @buildQuery = 'insert into magic44_data_capture (stepID, queryID, ';
    set @buildQuery = concat(@buildQuery, magic44_gen_simple_template(@numberOfColumns));
    set @buildQuery = concat(@buildQuery, ') select ');
    set @buildQuery = concat(@buildQuery, @stepCounter, ', ');
    set @buildQuery = concat(@buildQuery, thisQuery, ', practiceQuery');
    set @buildQuery = concat(@buildQuery, thisQuery, '.* from practiceQuery');
    set @buildQuery = concat(@buildQuery, thisQuery, ';');

return @buildQuery;
end //
delimiter ;

drop function if exists magic44_query_exists;
delimiter //
create function magic44_query_exists(thisQuery integer)
	returns integer deterministic
begin
	return (select exists (select * from information_schema.views
		where table_schema = @thisDatabase
        and table_name like concat('practiceQuery', thisQuery)));
end //
delimiter ;

-- Exception checking has been implemented to prevent (as much as reasonably possible) errors
-- in the queries being evaluated from interrupting the testing process
-- The magic44_log_query_errors table captures these errors for later review

drop table if exists magic44_log_query_errors;
create table magic44_log_query_errors (
	step_id integer,
    query_id integer,
    error_code char(5),
    error_message text
);

drop procedure if exists magic44_query_check_and_run;
delimiter //
create procedure magic44_query_check_and_run(in thisQuery integer)
begin
	declare err_code char(5) default '00000';
    declare err_msg text;

	declare continue handler for SQLEXCEPTION
    begin
		get diagnostics condition 1
			err_code = RETURNED_SQLSTATE, err_msg = MESSAGE_TEXT;
	end;

    declare continue handler for SQLWARNING
    begin
		get diagnostics condition 1
			err_code = RETURNED_SQLSTATE, err_msg = MESSAGE_TEXT;
	end;

	if magic44_query_exists(thisQuery) then
		set @sql_text = magic44_query_capture(thisQuery);
		prepare statement from @sql_text;
        execute statement;
        if err_code <> '00000' then
			insert into magic44_log_query_errors values (@stepCounter, thisQuery, err_code, err_msg);
		end if;
        deallocate prepare statement;
	end if;
end //
delimiter ;

-- ----------------------------------------------------------------------------------
-- [4] Organize the testing results by step and query identifiers
-- ----------------------------------------------------------------------------------

drop table if exists magic44_test_case_directory;
create table if not exists magic44_test_case_directory (
	base_step_id integer,
	number_of_steps integer,
    query_label char(20),
    query_name varchar(100),
    scoring_weight integer
);

insert into magic44_test_case_directory values
(0, 1, '[V_0]', 'initial_state_check',0),
(10, 2, '[C_1]', 'add_owner', 2),
(20, 4, '[C_2]', 'add_employee', 3),
(30, 4, '[C_3]', 'add_pilot_role', 1),
(40, 2, '[C_4]', 'add_worker_role', 1),
(50, 2, '[C_5]', 'add_ingredient', 1),
(60, 6, '[C_6]', 'add_drone', 2),
(70, 8, '[C_7]', 'add_restaurant', 2),
(80, 6, '[C_8]', 'add_service', 3),
(90, 4, '[C_9]', 'add_location', 1),
(100, 5, '[U_1]', 'start_funding', 1),
(110, 11, '[U_2]', 'hire_employee', 3),
(130, 6, '[U_3]', 'fire_employee', 2),
(140, 6, '[U_4]', 'manage_service', 3),
(150, 10, '[U_5]', 'takeover_drone', 2),
(170, 10, '[U_6]', 'join_swarm', 3),
(190, 4, '[U_7]', 'leave_swarm', 2),
(200, 12, '[U_8]', 'load_drone', 5),
(220, 4, '[U_9]', 'refuel_drone', 1),
(230, 16, '[U_A]', 'fly_drone', 8),
(250, 10, '[U_B]', 'purchase_ingredient', 13),
(270, 4, '[R_1]', 'remove_ingredient', 1),
(280, 6, '[R_2]', 'remove_drone', 2),
(290, 4, '[R_3]', 'remove_pilot_role', 5),
(300, 1, '[V_1]', 'display_owner_view', 5),
(310, 1, '[V_2]', 'display_employee_view', 1),
(320, 1, '[V_3]', 'display_pilot_view', 5),
(330, 1, '[V_4]', 'display_location_view', 3),
(340, 1, '[V_5]', 'display_ingredient_view', 3),
(350, 1, '[V_6]', 'display_service_view', 5),
(360, 6, '[E_1]', 'basic_single_drone', 13),
(370, 6, '[E_2]', 'basic_single_drone_with_views', 21),
(380, 14, '[E_3]', 'advanced_swarm_with_new_objects_and_views', 34);

drop table if exists magic44_scores_guide;
create table if not exists magic44_scores_guide (
    score_tag char(1),
    score_category varchar(100),
    display_order integer
);

insert into magic44_scores_guide values
('C', 'Create Transactions', 1), ('U', 'Use Case Transactions', 2),
('R', 'Remove Transactions', 3), ('V', 'Global Views/Queries', 4),
('E', 'Event Scenarios/Sequences', 5);

-- ----------------------------------------------------------------------------------
-- [5] Test the queries & transactions and store the results
-- ----------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------
/* Check that the initial state of their database matches the required configuration.
The magic44_reset_database_state() call is deliberately missing in order to evaluate
the state of the submitted database. */
-- ----------------------------------------------------------------------------------
set @stepCounter = 0;
call magic44_query_check_and_run(10); -- users
call magic44_query_check_and_run(11); -- restaurant_owners
call magic44_query_check_and_run(12); -- employees
call magic44_query_check_and_run(13); -- pilots
call magic44_query_check_and_run(14); -- workers
call magic44_query_check_and_run(15); -- ingredients
call magic44_query_check_and_run(16); -- locations
call magic44_query_check_and_run(17); -- restaurants
call magic44_query_check_and_run(18); -- delivery_services
call magic44_query_check_and_run(19); -- drones
call magic44_query_check_and_run(20); -- payload
call magic44_query_check_and_run(21); -- work_for

-- ----------------------------------------------------------------------------------
/* Check the unit test cases here.  The magic44_reset_database_state() call is used
for each test to ensure that the database state is set to the initial configuration.
The @stepCounter is set to index the test appropriately, and then the test call is
performed.  Finally, calls are made to the appropriate database tables to compare the
actual state changes to the expected state changes per our answer key. */
-- ----------------------------------------------------------------------------------
-- [1] add_owner() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 10;
call add_owner('lfibonacci5', 'Leonardo', 'Fibonacci', '144 Golden Ratio Spiral', '1170-01-01');
call magic44_query_check_and_run(10); -- users
call magic44_query_check_and_run(11); -- restaurant_owners

-- [2] add_employee() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 20;
call add_employee ('lfibonacci5', 'Leonardo', 'Fibonacci', '144 Golden Ratio Spiral', '1170-01-01',
    '112-35-8132', '2113-08-05', 34, 14489);
call magic44_query_check_and_run(10); -- users
call magic44_query_check_and_run(12); -- employees

-- [3] add_pilot_role() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 30;
call add_pilot_role ('mrobot1', '101010', 19);
call magic44_query_check_and_run(13); -- pilots

-- [4] add_worker_role() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 40;
call add_worker_role ('mrobot1');
call magic44_query_check_and_run(14); -- workers

-- [5] add_ingredient() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 50;
call add_ingredient ('wb_1Y2U3M', 'wagyu beef', 5);
call magic44_query_check_and_run(15); -- ingredients

-- [6] add_drone() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 60;
call add_drone ('osf', 4, 100, 10, 1000, 'awilson5');
call magic44_query_check_and_run(19); -- drones

-- [7] add_restaurant() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 70;
call add_restaurant ('Topolobampo', 5, 20, 'plaza');
call magic44_query_check_and_run(17); -- restaurants

-- [8] add_service() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 80;
call add_service ('wlt', 'Wolt', 'plaza', 'mrobot1');
call magic44_query_check_and_run(18); -- delivery_services

-- [9] add_location() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 90;
call add_location ('elysium', 2, 10, 4);
call magic44_query_check_and_run(16); -- locations

-- [10] start_funding() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 100;
call start_funding ('cjordan5', 'Tre Vele');
call magic44_query_check_and_run(17); -- restaurants

-- [11] hire_employee() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 110;
call hire_employee ('lrodriguez5', 'hf');
call magic44_query_check_and_run(21); -- work_for

-- [12] fire_employee() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 130;
call fire_employee ('tmccall5', 'hf');
call magic44_query_check_and_run(21); -- work_for

-- [13] manage_service() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 140;
call manage_service ('ckann5', 'osf');
call magic44_query_check_and_run(18); -- delivery_services
call magic44_query_check_and_run(14); -- workers

-- [14] takeover_drone() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 150;
call takeover_drone ('tmccall5', 'hf', 1);
call magic44_query_check_and_run(19); -- drones

-- [15] join_swarm() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 170;
call join_swarm ('hf', 8, 1);
call magic44_query_check_and_run(19); -- drones

-- [16] leave_swarm() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 190;
call leave_swarm ('hf', 11);
call magic44_query_check_and_run(19); -- drones

-- [17] load_drone() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 200;
call load_drone ('hf', 8, 'hs_5E7L23M', 2, 15);
call magic44_query_check_and_run(20); -- payload

-- [18] refuel_drone() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 220;
call refuel_drone ('hf', 0, 100);
call magic44_query_check_and_run(19); -- drones

-- [19] fly_drone() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 230;
call fly_drone ('osf', 1, 'plaza');
call magic44_query_check_and_run(19); -- drones

-- [20] purchase_ingredient() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 250;
call purchase_ingredient ('Ecco', 'hf', 5, 'hs_5E7L23M', 2);
call magic44_query_check_and_run(17); -- restaurants
call magic44_query_check_and_run(19); -- drones
call magic44_query_check_and_run(20); -- payload

-- [21] remove_ingredient() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 270;
call remove_ingredient ('ap_9T25E36L');
call magic44_query_check_and_run(15); -- ingredients

-- [22] remove_drone() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 280;
call remove_drone ('hf', 16);
call magic44_query_check_and_run(19); -- drones

-- [23] remove_pilot_role() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 290;
call remove_pilot_role ('lrodriguez5');
call magic44_query_check_and_run(10); -- users
call magic44_query_check_and_run(12); -- employees
call magic44_query_check_and_run(13); -- pilots

-- [24] display_owner_view() INITIAL STATE CHECK
call magic44_reset_database_state();
set @stepCounter = 300;
call magic44_query_check_and_run(30); -- display_owner_view

-- [25] display_employee_view() INITIAL STATE CHECK
call magic44_reset_database_state();
set @stepCounter = 310;
call magic44_query_check_and_run(31); -- display_employee_view

-- [26] display_pilot_view() INITIAL STATE CHECK
call magic44_reset_database_state();
set @stepCounter = 320;
call magic44_query_check_and_run(32); -- display_pilot_view

-- [27] display_location_view() INITIAL STATE CHECK
call magic44_reset_database_state();
set @stepCounter = 330;
call magic44_query_check_and_run(33); -- display_location_view

-- [28] display_ingredient_view() INITIAL STATE CHECK
call magic44_reset_database_state();
set @stepCounter = 340;
call magic44_query_check_and_run(34); -- display_ingredient_view

-- [29] display_service_view() INITIAL STATE CHECK
call magic44_reset_database_state();
set @stepCounter = 350;
call magic44_query_check_and_run(35); -- display_service_view

-- [30] Basic Single Drone: EVENT SCENARIO #1
call magic44_reset_database_state();
-- load & refuel single drone
set @stepCounter = 360;
call load_drone ('hf', 8, 'hs_5E7L23M', 3, 15);
call magic44_query_check_and_run(20); -- payload
call refuel_drone ('hf', 8, 10);
call magic44_query_check_and_run(19); -- drones
-- move drone to first restaurant location
set @stepCounter = @stepCounter + 1;
call fly_drone ('hf', 8, 'buckhead');
call magic44_query_check_and_run(19); -- drones
-- purchase multiple packages of different ingredients
set @stepCounter = @stepCounter + 1;
call purchase_ingredient ('Ecco', 'hf', 8, 'pr_3C6A9R', 2);
call purchase_ingredient ('Ecco', 'hf', 8, 'hs_5E7L23M', 1);
call magic44_query_check_and_run(17); -- restaurants
call magic44_query_check_and_run(19); -- drones
call magic44_query_check_and_run(20); -- payload
-- move drone to second restaurant location
set @stepCounter = @stepCounter + 1;
call fly_drone ('hf', 8, 'midtown');
call magic44_query_check_and_run(19); -- drones
-- purchase multiple packages of different ingredients
set @stepCounter = @stepCounter + 1;
call purchase_ingredient ('South City Kitchen', 'hf', 8, 'pr_3C6A9R', 1);
call purchase_ingredient ('Lure', 'hf', 8, 'hs_5E7L23M', 1);
call magic44_query_check_and_run(17); -- restaurants
call magic44_query_check_and_run(19); -- drones
call magic44_query_check_and_run(20); -- payload
-- return drone to home base
set @stepCounter = @stepCounter + 1;
call fly_drone ('hf', 8, 'southside');
call magic44_query_check_and_run(19); -- drones

-- ----------------------------------------------------------------------------------
-- [6] Collect and analyze the testing results for the student's submission
-- ----------------------------------------------------------------------------------

-- These tables are used to store the answers and test results.  The answers are generated by executing
-- the test script against our reference solution.  The test results are collected by running the test
-- script against your submission in order to compare the results.

-- The results from magic44_data_capture are transferred into the magic44_test_results table
drop table if exists magic44_test_results;
create table magic44_test_results (
	step_id integer not null,
    query_id integer,
	row_hash varchar(2000) not null
);

insert into magic44_test_results
select stepID, queryID, concat_ws('#', ifnull(columndump0, ''), ifnull(columndump1, ''), ifnull(columndump2, ''), ifnull(columndump3, ''),
ifnull(columndump4, ''), ifnull(columndump5, ''), ifnull(columndump6, ''), ifnull(columndump7, ''), ifnull(columndump8, ''), ifnull(columndump9, ''),
ifnull(columndump10, ''), ifnull(columndump11, ''), ifnull(columndump12, ''), ifnull(columndump13, ''), ifnull(columndump14, ''))
from magic44_data_capture;

-- the answers generated from the reference solution are loaded below
drop table if exists magic44_expected_results;
create table magic44_expected_results (
	step_id integer not null,
    query_id integer,
	row_hash varchar(2000) not null,
    index (step_id),
    index (query_id)
);

insert into magic44_expected_results values
(0,10,'agarcia7#alejandro#garcia#710livingwaterdrive#1966-10-29##########'),
(0,10,'awilson5#aaron#wilson#220peachtreestreet#1963-11-11##########'),
(0,10,'bsummers4#brie#summers#5105dragonstarcircle#1976-02-09##########'),
(0,10,'cjordan5#clark#jordan#77infinitestarsroad#1966-06-05##########'),
(0,10,'ckann5#carrot#kann#64knightssquaretrail#1972-09-01##########'),
(0,10,'csoares8#claire#soares#706livingstoneway#1965-09-03##########'),
(0,10,'echarles19#ella#charles#22peachtreestreet#1974-05-06##########'),
(0,10,'eross10#erica#ross#22peachtreestreet#1975-04-02##########'),
(0,10,'fprefontaine6#ford#prefontaine#10hitchhikerslane#1961-01-28##########'),
(0,10,'hstark16#harmon#stark#53tankertoplane#1971-10-27##########'),
(0,10,'jstone5#jared#stone#101fivefingerway#1961-01-06##########'),
(0,10,'lrodriguez5#lina#rodriguez#360corkscrewcircle#1975-04-02##########'),
(0,10,'mrobot1#mister#robot#10autonomytrace#1988-11-02##########'),
(0,10,'mrobot2#mister#robot#10clonemecircle#1988-11-02##########'),
(0,10,'rlopez6#radish#lopez#8queensroute#1999-09-03##########'),
(0,10,'sprince6#sarah#prince#22peachtreestreet#1968-06-15##########'),
(0,10,'tmccall5#trey#mccall#360corkscrewcircle#1973-03-19##########'),
(0,11,'cjordan5##############'),
(0,11,'jstone5##############'),
(0,11,'sprince6##############'),
(0,12,'agarcia7#999-99-9999#2019-03-17#24#41000##########'),
(0,12,'awilson5#111-11-1111#2020-03-15#9#46000##########'),
(0,12,'bsummers4#000-00-0000#2018-12-06#17#35000##########'),
(0,12,'ckann5#640-81-2357#2019-08-03#27#46000##########'),
(0,12,'csoares8#888-88-8888#2019-02-25#26#57000##########'),
(0,12,'echarles19#777-77-7777#2021-01-02#3#27000##########'),
(0,12,'eross10#444-44-4444#2020-04-17#10#61000##########'),
(0,12,'fprefontaine6#121-21-2121#2020-04-19#5#20000##########'),
(0,12,'hstark16#555-55-5555#2018-07-23#20#59000##########'),
(0,12,'lrodriguez5#222-22-2222#2019-04-15#20#58000##########'),
(0,12,'mrobot1#101-01-0101#2015-05-27#8#38000##########'),
(0,12,'mrobot2#010-10-1010#2015-05-27#8#38000##########'),
(0,12,'rlopez6#123-58-1321#2017-02-05#51#64000##########'),
(0,12,'tmccall5#333-33-3333#2018-10-17#29#33000##########'),
(0,13,'agarcia7#610623#38############'),
(0,13,'awilson5#314159#41############'),
(0,13,'bsummers4#411911#35############'),
(0,13,'csoares8#343563#7############'),
(0,13,'echarles19#236001#10############'),
(0,13,'fprefontaine6#657483#2############'),
(0,13,'lrodriguez5#287182#67############'),
(0,13,'mrobot1#101010#18############'),
(0,13,'rlopez6#235711#58############'),
(0,13,'tmccall5#181633#10############'),
(0,14,'ckann5##############'),
(0,14,'csoares8##############'),
(0,14,'echarles19##############'),
(0,14,'eross10##############'),
(0,14,'hstark16##############'),
(0,14,'mrobot2##############'),
(0,14,'tmccall5##############'),
(0,15,'ap_9t25e36l#foiegras#4############'),
(0,15,'bv_4u5l7m#balsamicvinegar#4############'),
(0,15,'clc_4t9u25x#caviar#5############'),
(0,15,'hs_5e7l23m#truffles#3############'),
(0,15,'pr_3c6a9r#prosciutto#6############'),
(0,15,'ss_2d4e6l#saffron#3############'),
(0,16,'airport#-2#-9#4###########'),
(0,16,'avalon#2#16#5###########'),
(0,16,'buckhead#3#8#4###########'),
(0,16,'highpoint#7#0#2###########'),
(0,16,'mercedes#1#1#2###########'),
(0,16,'midtown#1#4#3###########'),
(0,16,'plaza#5#12#20###########'),
(0,16,'southside#3#-6#3###########'),
(0,17,'bishoku#5#10#plaza###########'),
(0,17,'casicielo#5#30#plaza###########'),
(0,17,'ecco#3#0#buckhead#jstone5##########'),
(0,17,'fogodechao#4#30#buckhead###########'),
(0,17,'hearth#4#0#avalon###########'),
(0,17,'ilgiallo#4#10#mercedes#sprince6##########'),
(0,17,'lure#5#20#midtown#jstone5##########'),
(0,17,'micks#2#0#southside###########'),
(0,17,'southcitykitchen#5#30#midtown#jstone5##########'),
(0,17,'trevele#4#10#plaza###########'),
(0,18,'hf#herbanfeast#southside#hstark16###########'),
(0,18,'osf#onsafarifoods#southside#eross10###########'),
(0,18,'rr#ravishingradish#avalon#echarles19###########'),
(0,19,'hf#1#100#6#0#fprefontaine6###southside######'),
(0,19,'hf#5#27#7#100#fprefontaine6###buckhead######'),
(0,19,'hf#8#100#8#0#bsummers4###southside######'),
(0,19,'hf#11#25#10#0##hf#5#buckhead######'),
(0,19,'hf#16#17#5#40#fprefontaine6###buckhead######'),
(0,19,'osf#1#100#9#0#awilson5###airport######'),
(0,19,'osf#2#75#7#0##osf#1#airport######'),
(0,19,'rr#3#100#5#50#agarcia7###avalon######'),
(0,19,'rr#7#53#5#100#agarcia7###avalon######'),
(0,19,'rr#8#100#6#0#agarcia7###highpoint######'),
(0,19,'rr#11#90#6#0##rr#8#highpoint######'),
(0,20,'hf#1#ss_2d4e6l#6#27##########'),
(0,20,'hf#5#clc_4t9u25x#1#30##########'),
(0,20,'hf#5#hs_5e7l23m#4#17##########'),
(0,20,'hf#8#pr_3c6a9r#4#18##########'),
(0,20,'hf#11#ss_2d4e6l#3#19##########'),
(0,20,'osf#1#pr_3c6a9r#5#20##########'),
(0,20,'osf#1#ss_2d4e6l#3#23##########'),
(0,20,'osf#2#hs_5e7l23m#7#14##########'),
(0,20,'rr#3#clc_4t9u25x#2#28##########'),
(0,20,'rr#3#hs_5e7l23m#2#15##########'),
(0,21,'bsummers4#hf#############'),
(0,21,'fprefontaine6#hf#############'),
(0,21,'hstark16#hf#############'),
(0,21,'tmccall5#hf#############'),
(0,21,'awilson5#osf#############'),
(0,21,'ckann5#osf#############'),
(0,21,'eross10#osf#############'),
(0,21,'mrobot1#osf#############'),
(0,21,'agarcia7#rr#############'),
(0,21,'echarles19#rr#############'),
(0,21,'mrobot1#rr#############'),
(0,21,'rlopez6#rr#############'),
(10,10,'agarcia7#alejandro#garcia#710livingwaterdrive#1966-10-29##########'),
(10,10,'awilson5#aaron#wilson#220peachtreestreet#1963-11-11##########'),
(10,10,'bsummers4#brie#summers#5105dragonstarcircle#1976-02-09##########'),
(10,10,'cjordan5#clark#jordan#77infinitestarsroad#1966-06-05##########'),
(10,10,'ckann5#carrot#kann#64knightssquaretrail#1972-09-01##########'),
(10,10,'csoares8#claire#soares#706livingstoneway#1965-09-03##########'),
(10,10,'echarles19#ella#charles#22peachtreestreet#1974-05-06##########'),
(10,10,'eross10#erica#ross#22peachtreestreet#1975-04-02##########'),
(10,10,'fprefontaine6#ford#prefontaine#10hitchhikerslane#1961-01-28##########'),
(10,10,'hstark16#harmon#stark#53tankertoplane#1971-10-27##########'),
(10,10,'jstone5#jared#stone#101fivefingerway#1961-01-06##########'),
(10,10,'lfibonacci5#leonardo#fibonacci#144goldenratiospiral#1170-01-01##########'),
(10,10,'lrodriguez5#lina#rodriguez#360corkscrewcircle#1975-04-02##########'),
(10,10,'mrobot1#mister#robot#10autonomytrace#1988-11-02##########'),
(10,10,'mrobot2#mister#robot#10clonemecircle#1988-11-02##########'),
(10,10,'rlopez6#radish#lopez#8queensroute#1999-09-03##########'),
(10,10,'sprince6#sarah#prince#22peachtreestreet#1968-06-15##########'),
(10,10,'tmccall5#trey#mccall#360corkscrewcircle#1973-03-19##########'),
(10,11,'cjordan5##############'),
(10,11,'jstone5##############'),
(10,11,'lfibonacci5##############'),
(10,11,'sprince6##############'),
(20,10,'agarcia7#alejandro#garcia#710livingwaterdrive#1966-10-29##########'),
(20,10,'awilson5#aaron#wilson#220peachtreestreet#1963-11-11##########'),
(20,10,'bsummers4#brie#summers#5105dragonstarcircle#1976-02-09##########'),
(20,10,'cjordan5#clark#jordan#77infinitestarsroad#1966-06-05##########'),
(20,10,'ckann5#carrot#kann#64knightssquaretrail#1972-09-01##########'),
(20,10,'csoares8#claire#soares#706livingstoneway#1965-09-03##########'),
(20,10,'echarles19#ella#charles#22peachtreestreet#1974-05-06##########'),
(20,10,'eross10#erica#ross#22peachtreestreet#1975-04-02##########'),
(20,10,'fprefontaine6#ford#prefontaine#10hitchhikerslane#1961-01-28##########'),
(20,10,'hstark16#harmon#stark#53tankertoplane#1971-10-27##########'),
(20,10,'jstone5#jared#stone#101fivefingerway#1961-01-06##########'),
(20,10,'lfibonacci5#leonardo#fibonacci#144goldenratiospiral#1170-01-01##########'),
(20,10,'lrodriguez5#lina#rodriguez#360corkscrewcircle#1975-04-02##########'),
(20,10,'mrobot1#mister#robot#10autonomytrace#1988-11-02##########'),
(20,10,'mrobot2#mister#robot#10clonemecircle#1988-11-02##########'),
(20,10,'rlopez6#radish#lopez#8queensroute#1999-09-03##########'),
(20,10,'sprince6#sarah#prince#22peachtreestreet#1968-06-15##########'),
(20,10,'tmccall5#trey#mccall#360corkscrewcircle#1973-03-19##########'),
(20,12,'agarcia7#999-99-9999#2019-03-17#24#41000##########'),
(20,12,'awilson5#111-11-1111#2020-03-15#9#46000##########'),
(20,12,'bsummers4#000-00-0000#2018-12-06#17#35000##########'),
(20,12,'ckann5#640-81-2357#2019-08-03#27#46000##########'),
(20,12,'csoares8#888-88-8888#2019-02-25#26#57000##########'),
(20,12,'echarles19#777-77-7777#2021-01-02#3#27000##########'),
(20,12,'eross10#444-44-4444#2020-04-17#10#61000##########'),
(20,12,'fprefontaine6#121-21-2121#2020-04-19#5#20000##########'),
(20,12,'hstark16#555-55-5555#2018-07-23#20#59000##########'),
(20,12,'lfibonacci5#112-35-8132#2113-08-05#34#14489##########'),
(20,12,'lrodriguez5#222-22-2222#2019-04-15#20#58000##########'),
(20,12,'mrobot1#101-01-0101#2015-05-27#8#38000##########'),
(20,12,'mrobot2#010-10-1010#2015-05-27#8#38000##########'),
(20,12,'rlopez6#123-58-1321#2017-02-05#51#64000##########'),
(20,12,'tmccall5#333-33-3333#2018-10-17#29#33000##########'),
(30,13,'agarcia7#610623#38############'),
(30,13,'awilson5#314159#41############'),
(30,13,'bsummers4#411911#35############'),
(30,13,'csoares8#343563#7############'),
(30,13,'echarles19#236001#10############'),
(30,13,'fprefontaine6#657483#2############'),
(30,13,'lrodriguez5#287182#67############'),
(30,13,'mrobot1#101010#18############'),
(30,13,'rlopez6#235711#58############'),
(30,13,'tmccall5#181633#10############'),
(40,14,'ckann5##############'),
(40,14,'csoares8##############'),
(40,14,'echarles19##############'),
(40,14,'eross10##############'),
(40,14,'hstark16##############'),
(40,14,'mrobot1##############'),
(40,14,'mrobot2##############'),
(40,14,'tmccall5##############'),
(50,15,'ap_9t25e36l#foiegras#4############'),
(50,15,'bv_4u5l7m#balsamicvinegar#4############'),
(50,15,'clc_4t9u25x#caviar#5############'),
(50,15,'hs_5e7l23m#truffles#3############'),
(50,15,'pr_3c6a9r#prosciutto#6############'),
(50,15,'ss_2d4e6l#saffron#3############'),
(50,15,'wb_1y2u3m#wagyubeef#5############'),
(60,19,'hf#1#100#6#0#fprefontaine6###southside######'),
(60,19,'hf#5#27#7#100#fprefontaine6###buckhead######'),
(60,19,'hf#8#100#8#0#bsummers4###southside######'),
(60,19,'hf#11#25#10#0##hf#5#buckhead######'),
(60,19,'hf#16#17#5#40#fprefontaine6###buckhead######'),
(60,19,'osf#1#100#9#0#awilson5###airport######'),
(60,19,'osf#2#75#7#0##osf#1#airport######'),
(60,19,'osf#4#100#10#1000#awilson5###southside######'),
(60,19,'rr#3#100#5#50#agarcia7###avalon######'),
(60,19,'rr#7#53#5#100#agarcia7###avalon######'),
(60,19,'rr#8#100#6#0#agarcia7###highpoint######'),
(60,19,'rr#11#90#6#0##rr#8#highpoint######'),
(70,17,'bishoku#5#10#plaza###########'),
(70,17,'casicielo#5#30#plaza###########'),
(70,17,'ecco#3#0#buckhead#jstone5##########'),
(70,17,'fogodechao#4#30#buckhead###########'),
(70,17,'hearth#4#0#avalon###########'),
(70,17,'ilgiallo#4#10#mercedes#sprince6##########'),
(70,17,'lure#5#20#midtown#jstone5##########'),
(70,17,'micks#2#0#southside###########'),
(70,17,'southcitykitchen#5#30#midtown#jstone5##########'),
(70,17,'topolobampo#5#20#plaza###########'),
(70,17,'trevele#4#10#plaza###########'),
(80,18,'hf#herbanfeast#southside#hstark16###########'),
(80,18,'osf#onsafarifoods#southside#eross10###########'),
(80,18,'rr#ravishingradish#avalon#echarles19###########'),
(90,16,'airport#-2#-9#4###########'),
(90,16,'avalon#2#16#5###########'),
(90,16,'buckhead#3#8#4###########'),
(90,16,'elysium#2#10#4###########'),
(90,16,'highpoint#7#0#2###########'),
(90,16,'mercedes#1#1#2###########'),
(90,16,'midtown#1#4#3###########'),
(90,16,'plaza#5#12#20###########'),
(90,16,'southside#3#-6#3###########'),
(100,17,'bishoku#5#10#plaza###########'),
(100,17,'casicielo#5#30#plaza###########'),
(100,17,'ecco#3#0#buckhead#jstone5##########'),
(100,17,'fogodechao#4#30#buckhead###########'),
(100,17,'hearth#4#0#avalon###########'),
(100,17,'ilgiallo#4#10#mercedes#sprince6##########'),
(100,17,'lure#5#20#midtown#jstone5##########'),
(100,17,'micks#2#0#southside###########'),
(100,17,'southcitykitchen#5#30#midtown#jstone5##########'),
(100,17,'trevele#4#10#plaza#cjordan5##########'),
(110,21,'bsummers4#hf#############'),
(110,21,'fprefontaine6#hf#############'),
(110,21,'hstark16#hf#############'),
(110,21,'lrodriguez5#hf#############'),
(110,21,'tmccall5#hf#############'),
(110,21,'awilson5#osf#############'),
(110,21,'ckann5#osf#############'),
(110,21,'eross10#osf#############'),
(110,21,'mrobot1#osf#############'),
(110,21,'agarcia7#rr#############'),
(110,21,'echarles19#rr#############'),
(110,21,'mrobot1#rr#############'),
(110,21,'rlopez6#rr#############'),
(130,21,'bsummers4#hf#############'),
(130,21,'fprefontaine6#hf#############'),
(130,21,'hstark16#hf#############'),
(130,21,'awilson5#osf#############'),
(130,21,'ckann5#osf#############'),
(130,21,'eross10#osf#############'),
(130,21,'mrobot1#osf#############'),
(130,21,'agarcia7#rr#############'),
(130,21,'echarles19#rr#############'),
(130,21,'mrobot1#rr#############'),
(130,21,'rlopez6#rr#############'),
(140,18,'hf#herbanfeast#southside#hstark16###########'),
(140,18,'osf#onsafarifoods#southside#ckann5###########'),
(140,18,'rr#ravishingradish#avalon#echarles19###########'),
(140,14,'ckann5##############'),
(140,14,'csoares8##############'),
(140,14,'echarles19##############'),
(140,14,'eross10##############'),
(140,14,'hstark16##############'),
(140,14,'mrobot2##############'),
(140,14,'tmccall5##############'),
(150,19,'hf#1#100#6#0#tmccall5###southside######'),
(150,19,'hf#5#27#7#100#fprefontaine6###buckhead######'),
(150,19,'hf#8#100#8#0#bsummers4###southside######'),
(150,19,'hf#11#25#10#0##hf#5#buckhead######'),
(150,19,'hf#16#17#5#40#fprefontaine6###buckhead######'),
(150,19,'osf#1#100#9#0#awilson5###airport######'),
(150,19,'osf#2#75#7#0##osf#1#airport######'),
(150,19,'rr#3#100#5#50#agarcia7###avalon######'),
(150,19,'rr#7#53#5#100#agarcia7###avalon######'),
(150,19,'rr#8#100#6#0#agarcia7###highpoint######'),
(150,19,'rr#11#90#6#0##rr#8#highpoint######'),
(170,19,'hf#1#100#6#0#fprefontaine6###southside######'),
(170,19,'hf#5#27#7#100#fprefontaine6###buckhead######'),
(170,19,'hf#8#100#8#0##hf#1#southside######'),
(170,19,'hf#11#25#10#0##hf#5#buckhead######'),
(170,19,'hf#16#17#5#40#fprefontaine6###buckhead######'),
(170,19,'osf#1#100#9#0#awilson5###airport######'),
(170,19,'osf#2#75#7#0##osf#1#airport######'),
(170,19,'rr#3#100#5#50#agarcia7###avalon######'),
(170,19,'rr#7#53#5#100#agarcia7###avalon######'),
(170,19,'rr#8#100#6#0#agarcia7###highpoint######'),
(170,19,'rr#11#90#6#0##rr#8#highpoint######'),
(190,19,'hf#1#100#6#0#fprefontaine6###southside######'),
(190,19,'hf#5#27#7#100#fprefontaine6###buckhead######'),
(190,19,'hf#8#100#8#0#bsummers4###southside######'),
(190,19,'hf#11#25#10#0#fprefontaine6###buckhead######'),
(190,19,'hf#16#17#5#40#fprefontaine6###buckhead######'),
(190,19,'osf#1#100#9#0#awilson5###airport######'),
(190,19,'osf#2#75#7#0##osf#1#airport######'),
(190,19,'rr#3#100#5#50#agarcia7###avalon######'),
(190,19,'rr#7#53#5#100#agarcia7###avalon######'),
(190,19,'rr#8#100#6#0#agarcia7###highpoint######'),
(190,19,'rr#11#90#6#0##rr#8#highpoint######'),
(200,20,'hf#1#ss_2d4e6l#6#27##########'),
(200,20,'hf#5#clc_4t9u25x#1#30##########'),
(200,20,'hf#5#hs_5e7l23m#4#17##########'),
(200,20,'hf#8#hs_5e7l23m#2#15##########'),
(200,20,'hf#8#pr_3c6a9r#4#18##########'),
(200,20,'hf#11#ss_2d4e6l#3#19##########'),
(200,20,'osf#1#pr_3c6a9r#5#20##########'),
(200,20,'osf#1#ss_2d4e6l#3#23##########'),
(200,20,'osf#2#hs_5e7l23m#7#14##########'),
(200,20,'rr#3#clc_4t9u25x#2#28##########'),
(200,20,'rr#3#hs_5e7l23m#2#15##########'),
(220,19,'hf#1#100#6#0#fprefontaine6###southside######'),
(220,19,'hf#5#27#7#100#fprefontaine6###buckhead######'),
(220,19,'hf#8#100#8#0#bsummers4###southside######'),
(220,19,'hf#11#25#10#0##hf#5#buckhead######'),
(220,19,'hf#16#17#5#40#fprefontaine6###buckhead######'),
(220,19,'osf#1#100#9#0#awilson5###airport######'),
(220,19,'osf#2#75#7#0##osf#1#airport######'),
(220,19,'rr#3#100#5#50#agarcia7###avalon######'),
(220,19,'rr#7#53#5#100#agarcia7###avalon######'),
(220,19,'rr#8#100#6#0#agarcia7###highpoint######'),
(220,19,'rr#11#90#6#0##rr#8#highpoint######'),
(230,19,'hf#1#100#6#0#fprefontaine6###southside######'),
(230,19,'hf#5#27#7#100#fprefontaine6###buckhead######'),
(230,19,'hf#8#100#8#0#bsummers4###southside######'),
(230,19,'hf#11#25#10#0##hf#5#buckhead######'),
(230,19,'hf#16#17#5#40#fprefontaine6###buckhead######'),
(230,19,'osf#1#77#9#0#awilson5###plaza######'),
(230,19,'osf#2#52#7#0##osf#1#plaza######'),
(230,19,'rr#3#100#5#50#agarcia7###avalon######'),
(230,19,'rr#7#53#5#100#agarcia7###avalon######'),
(230,19,'rr#8#100#6#0#agarcia7###highpoint######'),
(230,19,'rr#11#90#6#0##rr#8#highpoint######'),
(250,17,'bishoku#5#10#plaza###########'),
(250,17,'casicielo#5#30#plaza###########'),
(250,17,'ecco#3#34#buckhead#jstone5##########'),
(250,17,'fogodechao#4#30#buckhead###########'),
(250,17,'hearth#4#0#avalon###########'),
(250,17,'ilgiallo#4#10#mercedes#sprince6##########'),
(250,17,'lure#5#20#midtown#jstone5##########'),
(250,17,'micks#2#0#southside###########'),
(250,17,'southcitykitchen#5#30#midtown#jstone5##########'),
(250,17,'trevele#4#10#plaza###########'),
(250,19,'hf#1#100#6#0#fprefontaine6###southside######'),
(250,19,'hf#5#27#7#134#fprefontaine6###buckhead######'),
(250,19,'hf#8#100#8#0#bsummers4###southside######'),
(250,19,'hf#11#25#10#0##hf#5#buckhead######'),
(250,19,'hf#16#17#5#40#fprefontaine6###buckhead######'),
(250,19,'osf#1#100#9#0#awilson5###airport######'),
(250,19,'osf#2#75#7#0##osf#1#airport######'),
(250,19,'rr#3#100#5#50#agarcia7###avalon######'),
(250,19,'rr#7#53#5#100#agarcia7###avalon######'),
(250,19,'rr#8#100#6#0#agarcia7###highpoint######'),
(250,19,'rr#11#90#6#0##rr#8#highpoint######'),
(250,20,'hf#1#ss_2d4e6l#6#27##########'),
(250,20,'hf#5#clc_4t9u25x#1#30##########'),
(250,20,'hf#5#hs_5e7l23m#2#17##########'),
(250,20,'hf#8#pr_3c6a9r#4#18##########'),
(250,20,'hf#11#ss_2d4e6l#3#19##########'),
(250,20,'osf#1#pr_3c6a9r#5#20##########'),
(250,20,'osf#1#ss_2d4e6l#3#23##########'),
(250,20,'osf#2#hs_5e7l23m#7#14##########'),
(250,20,'rr#3#clc_4t9u25x#2#28##########'),
(250,20,'rr#3#hs_5e7l23m#2#15##########'),
(270,15,'bv_4u5l7m#balsamicvinegar#4############'),
(270,15,'clc_4t9u25x#caviar#5############'),
(270,15,'hs_5e7l23m#truffles#3############'),
(270,15,'pr_3c6a9r#prosciutto#6############'),
(270,15,'ss_2d4e6l#saffron#3############'),
(280,19,'hf#1#100#6#0#fprefontaine6###southside######'),
(280,19,'hf#5#27#7#100#fprefontaine6###buckhead######'),
(280,19,'hf#8#100#8#0#bsummers4###southside######'),
(280,19,'hf#11#25#10#0##hf#5#buckhead######'),
(280,19,'osf#1#100#9#0#awilson5###airport######'),
(280,19,'osf#2#75#7#0##osf#1#airport######'),
(280,19,'rr#3#100#5#50#agarcia7###avalon######'),
(280,19,'rr#7#53#5#100#agarcia7###avalon######'),
(280,19,'rr#8#100#6#0#agarcia7###highpoint######'),
(280,19,'rr#11#90#6#0##rr#8#highpoint######'),
(290,10,'agarcia7#alejandro#garcia#710livingwaterdrive#1966-10-29##########'),
(290,10,'awilson5#aaron#wilson#220peachtreestreet#1963-11-11##########'),
(290,10,'bsummers4#brie#summers#5105dragonstarcircle#1976-02-09##########'),
(290,10,'cjordan5#clark#jordan#77infinitestarsroad#1966-06-05##########'),
(290,10,'ckann5#carrot#kann#64knightssquaretrail#1972-09-01##########'),
(290,10,'csoares8#claire#soares#706livingstoneway#1965-09-03##########'),
(290,10,'echarles19#ella#charles#22peachtreestreet#1974-05-06##########'),
(290,10,'eross10#erica#ross#22peachtreestreet#1975-04-02##########'),
(290,10,'fprefontaine6#ford#prefontaine#10hitchhikerslane#1961-01-28##########'),
(290,10,'hstark16#harmon#stark#53tankertoplane#1971-10-27##########'),
(290,10,'jstone5#jared#stone#101fivefingerway#1961-01-06##########'),
(290,10,'mrobot1#mister#robot#10autonomytrace#1988-11-02##########'),
(290,10,'mrobot2#mister#robot#10clonemecircle#1988-11-02##########'),
(290,10,'rlopez6#radish#lopez#8queensroute#1999-09-03##########'),
(290,10,'sprince6#sarah#prince#22peachtreestreet#1968-06-15##########'),
(290,10,'tmccall5#trey#mccall#360corkscrewcircle#1973-03-19##########'),
(290,12,'agarcia7#999-99-9999#2019-03-17#24#41000##########'),
(290,12,'awilson5#111-11-1111#2020-03-15#9#46000##########'),
(290,12,'bsummers4#000-00-0000#2018-12-06#17#35000##########'),
(290,12,'ckann5#640-81-2357#2019-08-03#27#46000##########'),
(290,12,'csoares8#888-88-8888#2019-02-25#26#57000##########'),
(290,12,'echarles19#777-77-7777#2021-01-02#3#27000##########'),
(290,12,'eross10#444-44-4444#2020-04-17#10#61000##########'),
(290,12,'fprefontaine6#121-21-2121#2020-04-19#5#20000##########'),
(290,12,'hstark16#555-55-5555#2018-07-23#20#59000##########'),
(290,12,'mrobot1#101-01-0101#2015-05-27#8#38000##########'),
(290,12,'mrobot2#010-10-1010#2015-05-27#8#38000##########'),
(290,12,'rlopez6#123-58-1321#2017-02-05#51#64000##########'),
(290,12,'tmccall5#333-33-3333#2018-10-17#29#33000##########'),
(290,13,'agarcia7#610623#38############'),
(290,13,'awilson5#314159#41############'),
(290,13,'bsummers4#411911#35############'),
(290,13,'csoares8#343563#7############'),
(290,13,'echarles19#236001#10############'),
(290,13,'fprefontaine6#657483#2############'),
(290,13,'mrobot1#101010#18############'),
(290,13,'rlopez6#235711#58############'),
(290,13,'tmccall5#181633#10############'),
(300,30,'cjordan5#clark#jordan#77infinitestarsroad#0#0#0#0#0######'),
(300,30,'jstone5#jared#stone#101fivefingerway#3#2#5#3#50######'),
(300,30,'sprince6#sarah#prince#22peachtreestreet#1#1#4#4#10######'),
(310,31,'agarcia7#999-99-9999#41000#2019-03-17#24#610623#38#no#######'),
(310,31,'awilson5#111-11-1111#46000#2020-03-15#9#314159#41#no#######'),
(310,31,'bsummers4#000-00-0000#35000#2018-12-06#17#411911#35#no#######'),
(310,31,'ckann5#640-81-2357#46000#2019-08-03#27#n/a#n/a#no#######'),
(310,31,'csoares8#888-88-8888#57000#2019-02-25#26#343563#7#no#######'),
(310,31,'echarles19#777-77-7777#27000#2021-01-02#3#236001#10#yes#######'),
(310,31,'eross10#444-44-4444#61000#2020-04-17#10#n/a#n/a#yes#######'),
(310,31,'fprefontaine6#121-21-2121#20000#2020-04-19#5#657483#2#no#######'),
(310,31,'hstark16#555-55-5555#59000#2018-07-23#20#n/a#n/a#yes#######'),
(310,31,'lrodriguez5#222-22-2222#58000#2019-04-15#20#287182#67#no#######'),
(310,31,'mrobot1#101-01-0101#38000#2015-05-27#8#101010#18#no#######'),
(310,31,'mrobot2#010-10-1010#38000#2015-05-27#8#n/a#n/a#no#######'),
(310,31,'rlopez6#123-58-1321#64000#2017-02-05#51#235711#58#no#######'),
(310,31,'tmccall5#333-33-3333#33000#2018-10-17#29#181633#10#no#######'),
(320,32,'agarcia7#610623#38#4#2##########'),
(320,32,'awilson5#314159#41#2#1##########'),
(320,32,'bsummers4#411911#35#1#1##########'),
(320,32,'csoares8#343563#7#0#0##########'),
(320,32,'echarles19#236001#10#0#0##########'),
(320,32,'fprefontaine6#657483#2#4#2##########'),
(320,32,'lrodriguez5#287182#67#0#0##########'),
(320,32,'mrobot1#101010#18#0#0##########'),
(320,32,'rlopez6#235711#58#0#0##########'),
(320,32,'tmccall5#181633#10#0#0##########'),
(330,33,'airport#-2#-9#0#0#2#########'),
(330,33,'avalon#2#16#1#1#2#########'),
(330,33,'buckhead#3#8#2#0#3#########'),
(330,33,'highpoint#7#0#0#0#2#########'),
(330,33,'mercedes#1#1#1#0#0#########'),
(330,33,'midtown#1#4#2#0#0#########'),
(330,33,'plaza#5#12#3#0#0#########'),
(330,33,'southside#3#-6#1#2#2#########'),
(340,34,'caviar#avalon#2#28#28##########'),
(340,34,'caviar#buckhead#1#30#30##########'),
(340,34,'prosciutto#airport#5#20#20##########'),
(340,34,'prosciutto#southside#4#18#18##########'),
(340,34,'saffron#airport#3#23#23##########'),
(340,34,'saffron#buckhead#3#19#19##########'),
(340,34,'saffron#southside#6#27#27##########'),
(340,34,'truffles#airport#7#14#14##########'),
(340,34,'truffles#avalon#2#15#15##########'),
(340,34,'truffles#buckhead#4#17#17##########'),
(350,35,'hf#herbanfeast#southside#hstark16#140#4#389#68#######'),
(350,35,'osf#onsafarifoods#southside#eross10#0#3#267#60#######'),
(350,35,'rr#ravishingradish#avalon#echarles19#150#2#86#16#######'),
(360,20,'hf#1#ss_2d4e6l#6#27##########'),
(360,20,'hf#5#clc_4t9u25x#1#30##########'),
(360,20,'hf#5#hs_5e7l23m#4#17##########'),
(360,20,'hf#8#hs_5e7l23m#3#15##########'),
(360,20,'hf#8#pr_3c6a9r#4#18##########'),
(360,20,'hf#11#ss_2d4e6l#3#19##########'),
(360,20,'osf#1#pr_3c6a9r#5#20##########'),
(360,20,'osf#1#ss_2d4e6l#3#23##########'),
(360,20,'osf#2#hs_5e7l23m#7#14##########'),
(360,20,'rr#3#clc_4t9u25x#2#28##########'),
(360,20,'rr#3#hs_5e7l23m#2#15##########'),
(360,19,'hf#1#100#6#0#fprefontaine6###southside######'),
(360,19,'hf#5#27#7#100#fprefontaine6###buckhead######'),
(360,19,'hf#8#110#8#0#bsummers4###southside######'),
(360,19,'hf#11#25#10#0##hf#5#buckhead######'),
(360,19,'hf#16#17#5#40#fprefontaine6###buckhead######'),
(360,19,'osf#1#100#9#0#awilson5###airport######'),
(360,19,'osf#2#75#7#0##osf#1#airport######'),
(360,19,'rr#3#100#5#50#agarcia7###avalon######'),
(360,19,'rr#7#53#5#100#agarcia7###avalon######'),
(360,19,'rr#8#100#6#0#agarcia7###highpoint######'),
(360,19,'rr#11#90#6#0##rr#8#highpoint######'),
(361,19,'hf#1#100#6#0#fprefontaine6###southside######'),
(361,19,'hf#5#27#7#100#fprefontaine6###buckhead######'),
(361,19,'hf#8#95#8#0#bsummers4###buckhead######'),
(361,19,'hf#11#25#10#0##hf#5#buckhead######'),
(361,19,'hf#16#17#5#40#fprefontaine6###buckhead######'),
(361,19,'osf#1#100#9#0#awilson5###airport######'),
(361,19,'osf#2#75#7#0##osf#1#airport######'),
(361,19,'rr#3#100#5#50#agarcia7###avalon######'),
(361,19,'rr#7#53#5#100#agarcia7###avalon######'),
(361,19,'rr#8#100#6#0#agarcia7###highpoint######'),
(361,19,'rr#11#90#6#0##rr#8#highpoint######'),
(362,17,'bishoku#5#10#plaza###########'),
(362,17,'casicielo#5#30#plaza###########'),
(362,17,'ecco#3#51#buckhead#jstone5##########'),
(362,17,'fogodechao#4#30#buckhead###########'),
(362,17,'hearth#4#0#avalon###########'),
(362,17,'ilgiallo#4#10#mercedes#sprince6##########'),
(362,17,'lure#5#20#midtown#jstone5##########'),
(362,17,'micks#2#0#southside###########'),
(362,17,'southcitykitchen#5#30#midtown#jstone5##########'),
(362,17,'trevele#4#10#plaza###########'),
(362,19,'hf#1#100#6#0#fprefontaine6###southside######'),
(362,19,'hf#5#27#7#100#fprefontaine6###buckhead######'),
(362,19,'hf#8#95#8#51#bsummers4###buckhead######'),
(362,19,'hf#11#25#10#0##hf#5#buckhead######'),
(362,19,'hf#16#17#5#40#fprefontaine6###buckhead######'),
(362,19,'osf#1#100#9#0#awilson5###airport######'),
(362,19,'osf#2#75#7#0##osf#1#airport######'),
(362,19,'rr#3#100#5#50#agarcia7###avalon######'),
(362,19,'rr#7#53#5#100#agarcia7###avalon######'),
(362,19,'rr#8#100#6#0#agarcia7###highpoint######'),
(362,19,'rr#11#90#6#0##rr#8#highpoint######'),
(362,20,'hf#1#ss_2d4e6l#6#27##########'),
(362,20,'hf#5#clc_4t9u25x#1#30##########'),
(362,20,'hf#5#hs_5e7l23m#4#17##########'),
(362,20,'hf#8#hs_5e7l23m#2#15##########'),
(362,20,'hf#8#pr_3c6a9r#2#18##########'),
(362,20,'hf#11#ss_2d4e6l#3#19##########'),
(362,20,'osf#1#pr_3c6a9r#5#20##########'),
(362,20,'osf#1#ss_2d4e6l#3#23##########'),
(362,20,'osf#2#hs_5e7l23m#7#14##########'),
(362,20,'rr#3#clc_4t9u25x#2#28##########'),
(362,20,'rr#3#hs_5e7l23m#2#15##########'),
(363,19,'hf#1#100#6#0#fprefontaine6###southside######'),
(363,19,'hf#5#27#7#100#fprefontaine6###buckhead######'),
(363,19,'hf#8#90#8#51#bsummers4###midtown######'),
(363,19,'hf#11#25#10#0##hf#5#buckhead######'),
(363,19,'hf#16#17#5#40#fprefontaine6###buckhead######'),
(363,19,'osf#1#100#9#0#awilson5###airport######'),
(363,19,'osf#2#75#7#0##osf#1#airport######'),
(363,19,'rr#3#100#5#50#agarcia7###avalon######'),
(363,19,'rr#7#53#5#100#agarcia7###avalon######'),
(363,19,'rr#8#100#6#0#agarcia7###highpoint######'),
(363,19,'rr#11#90#6#0##rr#8#highpoint######'),
(364,17,'bishoku#5#10#plaza###########'),
(364,17,'casicielo#5#30#plaza###########'),
(364,17,'ecco#3#51#buckhead#jstone5##########'),
(364,17,'fogodechao#4#30#buckhead###########'),
(364,17,'hearth#4#0#avalon###########'),
(364,17,'ilgiallo#4#10#mercedes#sprince6##########'),
(364,17,'lure#5#35#midtown#jstone5##########'),
(364,17,'micks#2#0#southside###########'),
(364,17,'southcitykitchen#5#48#midtown#jstone5##########'),
(364,17,'trevele#4#10#plaza###########'),
(364,19,'hf#1#100#6#0#fprefontaine6###southside######'),
(364,19,'hf#5#27#7#100#fprefontaine6###buckhead######'),
(364,19,'hf#8#90#8#84#bsummers4###midtown######'),
(364,19,'hf#11#25#10#0##hf#5#buckhead######'),
(364,19,'hf#16#17#5#40#fprefontaine6###buckhead######'),
(364,19,'osf#1#100#9#0#awilson5###airport######'),
(364,19,'osf#2#75#7#0##osf#1#airport######'),
(364,19,'rr#3#100#5#50#agarcia7###avalon######'),
(364,19,'rr#7#53#5#100#agarcia7###avalon######'),
(364,19,'rr#8#100#6#0#agarcia7###highpoint######'),
(364,19,'rr#11#90#6#0##rr#8#highpoint######'),
(364,20,'hf#1#ss_2d4e6l#6#27##########'),
(364,20,'hf#5#clc_4t9u25x#1#30##########'),
(364,20,'hf#5#hs_5e7l23m#4#17##########'),
(364,20,'hf#8#hs_5e7l23m#1#15##########'),
(364,20,'hf#8#pr_3c6a9r#1#18##########'),
(364,20,'hf#11#ss_2d4e6l#3#19##########'),
(364,20,'osf#1#pr_3c6a9r#5#20##########'),
(364,20,'osf#1#ss_2d4e6l#3#23##########'),
(364,20,'osf#2#hs_5e7l23m#7#14##########'),
(364,20,'rr#3#clc_4t9u25x#2#28##########'),
(364,20,'rr#3#hs_5e7l23m#2#15##########'),
(365,19,'hf#1#100#6#0#fprefontaine6###southside######'),
(365,19,'hf#5#27#7#100#fprefontaine6###buckhead######'),
(365,19,'hf#8#79#8#84#bsummers4###southside######'),
(365,19,'hf#11#25#10#0##hf#5#buckhead######'),
(365,19,'hf#16#17#5#40#fprefontaine6###buckhead######'),
(365,19,'osf#1#100#9#0#awilson5###airport######'),
(365,19,'osf#2#75#7#0##osf#1#airport######'),
(365,19,'rr#3#100#5#50#agarcia7###avalon######'),
(365,19,'rr#7#53#5#100#agarcia7###avalon######'),
(365,19,'rr#8#100#6#0#agarcia7###highpoint######'),
(365,19,'rr#11#90#6#0##rr#8#highpoint######');

-- ----------------------------------------------------------------------------------
-- [7] Compare & evaluate the testing results
-- ----------------------------------------------------------------------------------

-- Delete the unneeded rows from the answers table to simplify later analysis
-- delete from magic44_expected_results where not magic44_query_exists(query_id);

-- Modify the row hash results for the results table to eliminate spaces and convert all characters to lowercase
update magic44_test_results set row_hash = lower(replace(row_hash, ' ', ''));

-- The magic44_count_differences view displays the differences between the number of rows contained in the answers
-- and the test results.  The value null in the answer_total and result_total columns represents zero (0) rows for
-- that query result.

drop view if exists magic44_count_answers;
create view magic44_count_answers as
select step_id, query_id, count(*) as answer_total
from magic44_expected_results group by step_id, query_id;

drop view if exists magic44_count_test_results;
create view magic44_count_test_results as
select step_id, query_id, count(*) as result_total
from magic44_test_results group by step_id, query_id;

drop view if exists magic44_count_differences;
create view magic44_count_differences as
select magic44_count_answers.query_id, magic44_count_answers.step_id, answer_total, result_total
from magic44_count_answers left outer join magic44_count_test_results
	on magic44_count_answers.step_id = magic44_count_test_results.step_id
	and magic44_count_answers.query_id = magic44_count_test_results.query_id
where answer_total <> result_total or result_total is null
union
select magic44_count_test_results.query_id, magic44_count_test_results.step_id, answer_total, result_total
from magic44_count_test_results left outer join magic44_count_answers
	on magic44_count_test_results.step_id = magic44_count_answers.step_id
	and magic44_count_test_results.query_id = magic44_count_answers.query_id
where result_total <> answer_total or answer_total is null
order by query_id, step_id;

-- The magic44_content_differences view displays the differences between the answers and test results
-- in terms of the row attributes and values.  the error_category column contains missing for rows that
-- are not included in the test results but should be, while extra represents the rows that should not
-- be included in the test results.  the row_hash column contains the values of the row in a single
-- string with the attribute values separated by a selected delimiter (i.e., the pound sign/#).

drop view if exists magic44_content_differences;
create view magic44_content_differences as
select query_id, step_id, 'missing' as category, row_hash
from magic44_expected_results where row(step_id, query_id, row_hash) not in
	(select step_id, query_id, row_hash from magic44_test_results)
union
select query_id, step_id, 'extra' as category, row_hash
from magic44_test_results where row(step_id, query_id, row_hash) not in
	(select step_id, query_id, row_hash from magic44_expected_results)
order by query_id, step_id, row_hash;

drop view if exists magic44_result_set_size_errors;
create view magic44_result_set_size_errors as
select step_id, query_id, 'result_set_size' as err_category from magic44_count_differences
group by step_id, query_id;

drop view if exists magic44_attribute_value_errors;
create view magic44_attribute_value_errors as
select step_id, query_id, 'attribute_values' as err_category from magic44_content_differences
where row(step_id, query_id) not in (select step_id, query_id from magic44_count_differences)
group by step_id, query_id;

drop view if exists magic44_errors_assembled;
create view magic44_errors_assembled as
select * from magic44_result_set_size_errors
union
select * from magic44_attribute_value_errors;

drop table if exists magic44_row_count_errors;
create table magic44_row_count_errors
select * from magic44_count_differences
order by query_id, step_id;

drop table if exists magic44_column_errors;
create table magic44_column_errors
select * from magic44_content_differences
order by query_id, step_id, row_hash;

drop view if exists magic44_fast_expected_results;
create view magic44_fast_expected_results as
select step_id, query_id, query_label, query_name
from magic44_expected_results, magic44_test_case_directory
where base_step_id <= step_id and step_id <= (base_step_id + number_of_steps - 1)
group by step_id, query_id, query_label, query_name;

drop view if exists magic44_fast_row_based_errors;
create view magic44_fast_row_based_errors as
select step_id, query_id, query_label, query_name
from magic44_row_count_errors, magic44_test_case_directory
where base_step_id <= step_id and step_id <= (base_step_id + number_of_steps - 1)
group by step_id, query_id, query_label, query_name;

drop view if exists magic44_fast_column_based_errors;
create view magic44_fast_column_based_errors as
select step_id, query_id, query_label, query_name
from magic44_column_errors, magic44_test_case_directory
where base_step_id <= step_id and step_id <= (base_step_id + number_of_steps - 1)
group by step_id, query_id, query_label, query_name;

drop view if exists magic44_fast_total_test_cases;
create view magic44_fast_total_test_cases as
select query_label, query_name, count(*) as total_cases
from magic44_fast_expected_results group by query_label, query_name;

drop view if exists magic44_fast_correct_test_cases;
create view magic44_fast_correct_test_cases as
select query_label, query_name, count(*) as correct_cases
from magic44_fast_expected_results where row(step_id, query_id) not in
(select step_id, query_id from magic44_fast_row_based_errors
union select step_id, query_id from magic44_fast_column_based_errors)
group by query_label, query_name;

drop table if exists magic44_autograding_low_level;
create table magic44_autograding_low_level
select magic44_fast_total_test_cases.*, ifnull(correct_cases, 0) as passed_cases
from magic44_fast_total_test_cases left outer join magic44_fast_correct_test_cases
on magic44_fast_total_test_cases.query_label = magic44_fast_correct_test_cases.query_label
and magic44_fast_total_test_cases.query_name = magic44_fast_correct_test_cases.query_name;

drop table if exists magic44_autograding_score_summary;
create table magic44_autograding_score_summary
select query_label, query_name,
	round(scoring_weight * passed_cases / total_cases, 2) as final_score, scoring_weight
from magic44_autograding_low_level natural join magic44_test_case_directory
where passed_cases < total_cases
union
select null, 'REMAINING CORRECT CASES', sum(round(scoring_weight * passed_cases / total_cases, 2)), null
from magic44_autograding_low_level natural join magic44_test_case_directory
where passed_cases = total_cases
union
select null, 'TOTAL SCORE', sum(round(scoring_weight * passed_cases / total_cases, 2)), null
from magic44_autograding_low_level natural join magic44_test_case_directory;

drop table if exists magic44_autograding_high_level;
create table magic44_autograding_high_level
select score_tag, score_category, sum(total_cases) as total_possible,
	sum(passed_cases) as total_passed
from magic44_scores_guide natural join
(select *, mid(query_label, 2, 1) as score_tag from magic44_autograding_low_level) as temp
group by score_tag, score_category; -- order by display_order;

-- Evaluate potential query errors against the original state and the modified state
drop view if exists magic44_result_errs_original;
create view magic44_result_errs_original as
select distinct 'row_count_errors_initial_state' as title, query_id
from magic44_row_count_errors where step_id = 0;

drop view if exists magic44_result_errs_modified;
create view magic44_result_errs_modified as
select distinct 'row_count_errors_test_cases' as title, query_id
from magic44_row_count_errors
where query_id not in (select query_id from magic44_result_errs_original)
union
select * from magic44_result_errs_original;

drop view if exists magic44_attribute_errs_original;
create view magic44_attribute_errs_original as
select distinct 'column_errors_initial_state' as title, query_id
from magic44_column_errors where step_id = 0
and query_id not in (select query_id from magic44_result_errs_modified)
union
select * from magic44_result_errs_modified;

drop view if exists magic44_attribute_errs_modified;
create view magic44_attribute_errs_modified as
select distinct 'column_errors_test_cases' as title, query_id
from magic44_column_errors
where query_id not in (select query_id from magic44_attribute_errs_original)
union
select * from magic44_attribute_errs_original;

drop view if exists magic44_correct_remainders;
create view magic44_correct_remainders as
select distinct 'fully_correct' as title, query_id
from magic44_test_results
where query_id not in (select query_id from magic44_attribute_errs_modified)
union
select * from magic44_attribute_errs_modified;

drop view if exists magic44_grading_rollups;
create view magic44_grading_rollups as
select title, count(*) as number_affected, group_concat(query_id order by query_id asc) as queries_affected
from magic44_correct_remainders
group by title;

drop table if exists magic44_autograding_directory;
create table magic44_autograding_directory (query_status_category varchar(1000));
insert into magic44_autograding_directory values ('fully_correct'),
('column_errors_initial_state'), ('row_count_errors_initial_state'),
('column_errors_test_cases'), ('row_count_errors_test_cases');

drop table if exists magic44_autograding_query_level;
create table magic44_autograding_query_level
select query_status_category, number_affected, queries_affected
from magic44_autograding_directory left outer join magic44_grading_rollups
on query_status_category = title;

-- ----------------------------------------------------------------------------------
-- Validate/verify that the test case results are correct
-- The test case results are compared to the initial database state contents
-- ----------------------------------------------------------------------------------

drop procedure if exists magic44_check_test_case;
delimiter //
create procedure magic44_check_test_case(in ip_test_case_number integer)
begin
	select * from (select query_id, 'added' as category, row_hash
	from magic44_test_results where step_id = ip_test_case_number and row(query_id, row_hash) not in
		(select query_id, row_hash from magic44_expected_results where step_id = 0)
	union
	select temp.query_id, 'removed' as category, temp.row_hash
	from (select query_id, row_hash from magic44_expected_results where step_id = 0) as temp
	where row(temp.query_id, temp.row_hash) not in
		(select query_id, row_hash from magic44_test_results where step_id = ip_test_case_number)
	and temp.query_id in
		(select query_id from magic44_test_results where step_id = ip_test_case_number)) as unified
	order by query_id, row_hash;
end //
delimiter ;

-- ----------------------------------------------------------------------------------
-- [8] Generate views to help interpret the test results more easily
-- ----------------------------------------------------------------------------------
drop table if exists magic44_table_name_lookup;
create table magic44_table_name_lookup (
	query_id integer,
	table_or_view_name varchar(2000),
    primary key (query_id)
);

insert into magic44_table_name_lookup values
(10, 'users'), (11, 'restaurant_owners'), (12, 'employees'), (13, 'pilots'),
(14, 'workers'), (15, 'ingredients'), (16, 'locations'), (17, 'restaurants'),
(18, 'delivery_services'), (19, 'drones'), (20, 'payload'), (21, 'work_for'),
(30, 'display_owner_view'), (31, 'display_employee_view'),
(32, 'display_pilot_view'), (33, 'display_location_view'),
(34, 'display_ingredient_view'), (35, 'display_service_view');

create or replace view magic44_column_errors_traceable as
select query_label as test_category, query_name as test_name, step_id as test_step_counter,
	table_or_view_name, category as error_category, row_hash
from (magic44_column_errors join magic44_test_case_directory
on (step_id between base_step_id and base_step_id + number_of_steps - 1))
natural join magic44_table_name_lookup
order by test_category, test_step_counter, row_hash;

-- ----------------------------------------------------------------------------------
-- [9] Remove unneeded tables, views, stored procedures and functions
-- ----------------------------------------------------------------------------------
-- Keep only those structures needed to provide student feedback
drop table if exists magic44_autograding_directory;

drop view if exists magic44_grading_rollups;
drop view if exists magic44_correct_remainders;
drop view if exists magic44_attribute_errs_modified;
drop view if exists magic44_attribute_errs_original;
drop view if exists magic44_result_errs_modified;
drop view if exists magic44_result_errs_original;
drop view if exists magic44_errors_assembled;
drop view if exists magic44_attribute_value_errors;
drop view if exists magic44_result_set_size_errors;
drop view if exists magic44_content_differences;
drop view if exists magic44_count_differences;
drop view if exists magic44_count_test_results;
drop view if exists magic44_count_answers;

drop procedure if exists magic44_query_check_and_run;

drop function if exists magic44_query_exists;
drop function if exists magic44_query_capture;
drop function if exists magic44_gen_simple_template;

drop table if exists magic44_column_listing;

-- The magic44_reset_database_state() and magic44_check_test_case procedures can be
-- dropped if desired, but they might be helpful for troubleshooting
-- drop procedure if exists magic44_reset_database_state;
-- drop procedure if exists magic44_check_test_case;

drop view if exists practiceQuery10;
drop view if exists practiceQuery11;
drop view if exists practiceQuery12;
drop view if exists practiceQuery13;
drop view if exists practiceQuery14;
drop view if exists practiceQuery15;
drop view if exists practiceQuery16;
drop view if exists practiceQuery17;
drop view if exists practiceQuery18;
drop view if exists practiceQuery19;
drop view if exists practiceQuery20;
drop view if exists practiceQuery21;

drop view if exists practiceQuery30;
drop view if exists practiceQuery31;
drop view if exists practiceQuery32;
drop view if exists practiceQuery33;
drop view if exists practiceQuery34;
drop view if exists practiceQuery35;

drop view if exists magic44_fast_correct_test_cases;
drop view if exists magic44_fast_total_test_cases;
drop view if exists magic44_fast_column_based_errors;
drop view if exists magic44_fast_row_based_errors;
drop view if exists magic44_fast_expected_results;

drop table if exists magic44_scores_guide;
