create database lista7ex3;
use lista7ex3;

create table contacorrente(
	nconta		int				not null, 
	cliente		varchar(90)		not null,
	saldo		decimal(9,2)	not null
	primary key(nconta)
);
insert into contacorrente values (1,'Joãozinho Garrafinha', 5000.00);

select nconta as 'Número da conta',
	   cliente as 'Cliente',
	   saldo as 'Saldo da conta'
from contacorrente;

create table movimentocc(
	id_mov		int				not null,
	nconta		int				not null,
	dt_mov		datetime		not null,
	valor		decimal(9,2)	not null,
	operacao	varchar(1)		not null,
	primary key(id_mov)
	foreign key (nconta) references contacorrente(nconta)
);

go
create procedure inserirclientes
	@nconta		int,
	@cliente	varchar(90),
	@saldo		decimal(9,2)
as
begin
	if @nconta <> 0 and @cliente <> ''
	begin
		insert into contacorrente (nconta, cliente, saldo) values (@nconta, @cliente, @saldo);
		print 'Cliente inserido com sucesso. se tentar duplicar, o sistema de banco de dados irá avisar.';
	end
end;

exec inserirclientes
@nconta = 2,
@cliente = 'Mariazinha Mesinha',
@saldo = 10000.00;


go
create procedure lancamentodebesaque
	@nconta		int,				
	@dt_mov		datetime,		
	@valor		decimal(9,2),	
	@operacao	varchar(1)
as
begin

	if @operacao = 'D' or @operacao = 'S'
	begin
		insert into movimentocc (nconta, dt_mov, valor, operacao) values (@nconta, @dt_mov, @valor, @operacao)
	end;

	if @operacao = 'D'
		begin
			update contacorrente
			set saldo = saldo + @valor
			where nconta = @nconta;
			print 'Depósito realizado com sucesso.'
		end;

	else if @operacao = 'S'
		begin 
		
			if (select saldo from contacorrente where nconta = @nconta) >= @valor
			begin
				update contacorrente
				set saldo = saldo - @valor
				where nconta = @nconta;
				print 'Saque realizado com sucesso.'
			end
			else
			begin
				
				print 'Erro: Saldo insuficiente. transação não concluída no saldo.'
			end
		end;
end;

exec lancamentodebesaque
	@nconta		= 2,			
	@dt_mov		= getdate(),
	@valor		= 3000,
	@operacao	= 'D';

exec lancamentodebesaque
	@nconta		= 2,			
	@dt_mov		= getdate(),
	@valor		= 15000, 
	@operacao	= 'S';

select * from contacorrente;