                           # PART 1:US Household Income Data Cleaning

# Identify the dupliactes rows
Select id, count(id)
From USHouseholdIncome
Group by id
Having count(id) > 1;

# adding the row_id to the dupliactes values
Select * 
From (
Select row_id, id,
row_number() over (partition by id order by id) row_num
from USHouseholdIncome
) duplicates
where row_num > 1;

# deleting the dupliactes values
Delete from USHouseholdIncome
Where row_id in (
	Select row_id
	From (
	Select row_id, id,
	row_number() over (partition by id order by id) row_num
	from USHouseholdIncome
	) duplicates
	where row_num > 1 );
    
#checking the spelling of alabama state and discovering that georgia state isnt properly written georia

Select state_name, count(state_name)
From USHouseholdIncome
Group by state_name;

# modifying the georia and alabama
Update USHouseholdIncome
Set state_name = 'Georgia'
where state_name = 'georia';

Update USHouseholdIncome
set state_name = 'Alabama';

#checking the place column where one value is missing and populate it with autaugaville

# lets look at the column type 
select type, count(type)
from USHouseholdIncome
group by type;

# update boroughs to make it borough
update USHouseholdIncome
set type = 'Borough' 
where type = 'Boroughs'; 