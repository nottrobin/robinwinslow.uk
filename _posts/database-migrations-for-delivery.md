Database migrations for delivery:

1. Create order type table (with values)

2. Add OrderTypeID column to [order]

3. Update [order]

	update [Order] set orderTypeID = 1 where OrderType = 'M2M';
	update [Order] set orderTypeID = 2 where OrderType = 'SHU';
	update [Order] set orderTypeID = 3 where OrderType = 'SP';
	update [Order] set orderTypeID = 4 where OrderType = 'WS';

4. Make [order].[OrderTypeID] mandatory

5. Delete [order].[OrderType]

6. Update stored procedures:

- Order_Insert

7. Copy stored procedures:

- OrderType_SelectAll
- OrderType_SelectByName
- OrderType_SelectById
