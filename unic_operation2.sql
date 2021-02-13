select 
DISTINCT on (microloan.client_id) microloan.client_id,
substring (microloan.full_number for 4) as заключен,
office.name_short as office, 
microloan.full_number, 
credit_product.name,
client.lastname,
client.firstname, 
client.secondname,
operation.type,
concat('https://shvidkozaim.net.ua:9000/i#cards/',microloan.client_id,'/loan/',microloan.id) as ссылка
from operation 

LEFT JOIN 
public.microloan ON operation.loan_id = microloan.id 

LEFT JOIN 
public.client ON microloan.client_id = client.id 

LEFT JOIN 
public.credit_product ON microloan.creditproduct_id = credit_product.id

LEFT JOIN 
public.office ON operation.office_id = office.id 

WHERE date_added = (SELECT MAX(date_added) FROM operation WHERE operation.loan_id  = microloan.id and date_added >= '2020-11-01 00:00:00' and date_added <= '2020-11-30 23:59:59')

GROUP BY
date_added, microloan.client_id, office, microloan.full_number, credit_product.name, client.lastname, client.firstname, client.secondname, operation.type,ссылка

ORDER BY microloan.client_id



