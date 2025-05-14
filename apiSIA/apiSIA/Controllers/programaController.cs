using System.Web.Http;
using System.Web.Http.Cors;
using apiSIA.Clases;
using apiSIA.Models;
using System.Collections.Generic;
using static apiSIA.Clases.clsOpeProg;

namespace apiSIA.Controllers
{
    [EnableCors(origins: "http://localhost:52965", headers: "*", methods: "*")]
    [RoutePrefix("api/programa")]
    public class programaController : ApiController
    {
        private clsOpeProg oX = new clsOpeProg();

        // GET: api/programa/{id}
        [HttpGet]
        [Route("{id:int}")]
        public IHttpActionResult Get(int id)
        {
            var programas = oX.consultarProgramasPorFacultad(id);

            if (programas == null || programas.Count == 0)
            {
                return NotFound();
            }

            return Ok(new clsOpeProg.ResponseModel
            {
                Exitoso = true,
                Mensaje = "Programas encontrados",
                Data = programas
            });
        }
    }
}