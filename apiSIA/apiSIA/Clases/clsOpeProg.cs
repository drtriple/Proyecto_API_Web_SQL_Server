using Antlr.Runtime;
using apiSIA.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace apiSIA.Clases
{
	public class clsOpeProg
	{
        private bdSIAEntities oSia = new bdSIAEntities();
        public tblPrograma tblProg { get; set; }

    // Clase para manejar las respuestas de manera estandarizada
        public class ResponseModel
        {
            public bool Exitoso { get; set; }
            public string Mensaje { get; set; }
            public object Data { get; set; }
        }

        public List<tblPrograma> consultarProgramasPorFacultad(int codigo)
        {
            return oSia.tblProgramas
            .Where(x => x.Activo == true && x.idFAC == codigo)
            .ToList();
        }
    }
}