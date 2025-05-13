using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using apiSIA.Models;

namespace apiSIA.Clases
{
    public class clsOpeFac
    {
        private bdSIAEntities oSia = new bdSIAEntities();
        public tblFacultad tblFac { get; set; }

        // Clase para manejar las respuestas de manera estandarizada
        public class ResponseModel
        {
            public bool Exitoso { get; set; }
            public string Mensaje { get; set; }
            public object Data { get; set; }
        }

        // 1. Listar todas las facultades activas
        public List<tblFacultad> listarFacultades()
        {
            return oSia.tblFacultads
                       //.Where(x => x.Activo == true)
                       .OrderBy(x => x.Nombre)
                       .ToList();
        }

        // 2. Consultar facultad por código
        public tblFacultad consultarFacultad(int codigo)
        {
            return oSia.tblFacultads.FirstOrDefault(x => x.Codigo == codigo);
        }

        // 3. Agregar una nueva facultad
        public ResponseModel agregarFacultad(tblFacultad facultad)
        {
            ResponseModel response = new ResponseModel();

            try
            {
                // Verificar si ya existe una facultad con el mismo código
                var facultadExistente = oSia.tblFacultads.FirstOrDefault(x => x.Codigo == facultad.Codigo);

                if (facultadExistente != null)
                {
                    response.Mensaje = "Ya existe una facultad con el código " + facultad.Codigo;
                    response.Exitoso = false;
                    return response;
                }

                // Si no existe, agregar la nueva facultad
                facultad.Activo = facultad.Activo ?? true; // Si no se especifica, por defecto es activa
                oSia.tblFacultads.Add(facultad);
                oSia.SaveChanges();

                response.Mensaje = "Facultad agregada correctamente";
                response.Exitoso = true;
                response.Data = facultad;
            }
            catch (Exception ex)
            {
                response.Mensaje = "Error al agregar la facultad: " + ex.Message;
                response.Exitoso = false;
            }

            return response;
        }

        // 4. Actualizar una facultad existente
        public ResponseModel actualizarFacultad(tblFacultad facultad)
        {
            ResponseModel response = new ResponseModel();

            try
            {
                var facultadExistente = oSia.tblFacultads.FirstOrDefault(x => x.Codigo == facultad.Codigo);

                if (facultadExistente == null)
                {
                    response.Mensaje = "No existe una facultad con el código " + facultad.Codigo;
                    response.Exitoso = false;
                    return response;
                }

                // Actualizar los campos necesarios
                facultadExistente.Nombre = facultad.Nombre;
                facultadExistente.Activo = facultad.Activo;

                oSia.Entry(facultadExistente).State = EntityState.Modified;
                oSia.SaveChanges();

                response.Mensaje = "Facultad actualizada correctamente";
                response.Exitoso = true;
                response.Data = facultadExistente;
            }
            catch (Exception ex)
            {
                response.Mensaje = "Error al actualizar la facultad: " + ex.Message;
                response.Exitoso = false;
            }

            return response;
        }

        // 5. Eliminar una facultad (eliminado lógico)
        public ResponseModel eliminarFacultad(int codigo)
        {
            ResponseModel response = new ResponseModel();

            try
            {
                var facultad = oSia.tblFacultads.FirstOrDefault(x => x.Codigo == codigo);

                if (facultad == null)
                {
                    response.Mensaje = "No existe una facultad con el código " + codigo;
                    response.Exitoso = false;
                    return response;
                }

                // Verificar si la facultad tiene programas asociados
                if (facultad.tblProgramas.Count > 0)
                {
                    response.Mensaje = "No se puede eliminar la facultad porque tiene programas asociados";
                    response.Exitoso = false;
                    return response;
                }

                // Eliminado lógico (cambiar estado a inactivo)
                facultad.Activo = false;
                oSia.Entry(facultad).State = EntityState.Modified;

                // Alternativa: Eliminado físico
                // oSia.tblFacultads.Remove(facultad);

                oSia.SaveChanges();

                response.Mensaje = "Facultad eliminada correctamente";
                response.Exitoso = true;
            }
            catch (Exception ex)
            {
                response.Mensaje = "Error al eliminar la facultad: " + ex.Message;
                response.Exitoso = false;
            }

            return response;
        }

}
}