declare
  vCursor 
begin
--  Citas con X dias de anticipacion
select c.fecha_cita,c.cod_servicio, c.cedula_pac, p.nom_pac, p.ape_pac, p.cod_tel_pac_cel,nvl(p.tel_pac_cel,p.celular) celular
from cl_cita c, cl_paciente p,cl_servicio s 
where c.cod_servicio = s.cod_servicio
  and c.cedula_pac = p.cedula_pac
  and TO_CHAR(c.fecha_cita, 'DD/MM/YYYY') = TO_CHAR(sysdate + :pi_dias, 'DD/MM/YYYY')
  and c.cod_servicio = NVL(:pi_cod_servicio,c.cod_servicio)
  and c.status_cita = 'S'; --Cita Solicitada
end;
/*  
--------------------------------------------------

select cod_servicio, descripcion
from cl_servicio 
where tipo_servicio = 'S' --Servicio


----------------

select * from cl_clientes
*/  
  
