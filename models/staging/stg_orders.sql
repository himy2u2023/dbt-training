select 
{{dbt_utils.generate_surrogate_key(['o.orderid','c.customerid','p.productid']) }} as sk_orders,
-- from raw_orders
o.orderid,o.orderdate,o.shipdate,o.shipmode

, ordersellingprice-ordercostprice as orderprofit
, ordersellingprice,ordercostprice
--from raw_customer
,c.customerid,c.customername,c.segment, c.country
-- from raw product
,p.productid, p.category, p.productname, p.subcategory
,{{ markup('ordersellingprice','ordercostprice') }} as markup
 from {{ ref('raw_orders') }} as o
 left join {{ ref('raw_customer') }} as c
 on o.customerid = c.customerid 
 left join {{ ref('raw_product') }} p
 on o.productid = p.productid