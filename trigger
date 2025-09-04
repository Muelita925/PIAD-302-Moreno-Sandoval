--CREATE TRIIGGERS
--INSERT,UDPATE, DELETE
select*from UserLogs;
delete from Productos where IdProducto = 1;
Update Productos
SET PrecioUnidad = 20
where IdProducto = 2
--Drop TABLE Userlogs

create table Userlogs (
id int primary key identity(1, 1),
[action] varchar (100),
[user] varchar(100),
[date] datetime
);


select * from UserLogs

create trigger trigger_delete_Productos ON Productos
after 
   delete
as
   insert into Userlogs ([action], [user], [date])
   Values('delete', SUSER_NAME(), SYSDATETIME())
 
 --crear trigger para la tabla users cuando se actualice um registro
create trigger trigger_updates_Productos ON Productos
after 
   update
as
   insert into Userlogs ([action], [user], [date])
   Values('Update', SUSER_NAME(), SYSDATETIME())
drop trigger trigger_update_Productos;

--otro trigger

create table Userlogss (
Userlogs int primary key identity(1, 1),
[action] varchar (100),
[user] varchar(100),
[date] datetime,
[detalle] varchar(200)
);

Select * from Userlogs
Select * from Productos

CREATE TRIGGER trigger_update_Productos
ON Productos 
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Userlogss ([action], [user], [date], [detalle])
    SELECT
        'Update',
        SUSER_NAME(),
        SYSDATETIME(),
        'ID Producto: ' + CAST(i.IdProducto AS NVARCHAR(50)) +
        ', Nombre anterior: ' + ISNULL(d.NombreProducto, 'NULL') +
        ', Nombre nuevo: ' + ISNULL(i.NombreProducto, 'NULL')
    FROM inserted i
    INNER JOIN deleted d ON i.IdProducto = d.IdProducto;
END;
go

drop trigger trigger_update_Productos

go

--trigger para delete y update
Create trigger trigger_update_Productos
on Productos
After update, delete 
As
Begin
     Set Nocount On;

	 Declare @accion NVARCHAR(10);
	 IF exists (Select * from inserted)
	    Set @accion = 'Update';
     ELSE
	    sET @accion = 'Delete';
	
	INSERT INTO UserLogs([action], [user], [date])
    VALUES (@accion, SUSER_NAME(), SYSDATETIME());
END
go
select * from UserLogs
select*from Productos;
delete from Productos where IdProducto = 1;
UPDATE Productos
    SET PrecioUnidad = '21.0000'
      where IdProducto = 2;