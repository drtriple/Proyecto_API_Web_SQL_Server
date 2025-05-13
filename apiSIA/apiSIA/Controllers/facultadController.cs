using System.Web.Http;
using System.Web.Http.Cors;
using apiSIA.Clases;
using apiSIA.Models;
using System.Collections.Generic;
using static apiSIA.Clases.clsOpeFac;

namespace apiSIA.Controllers
{
    [EnableCors(origins: "http://localhost:52965", headers: "*", methods: "*")]
    [RoutePrefix("api/facultad")]
    public class facultadController : ApiController
    {
        private clsOpeFac oX = new clsOpeFac();

        // GET: api/facultad
        [HttpGet]
        [Route("")]
        public List<tblFacultad> Get()
        {
            return oX.listarFacultades();
        }

        // GET: api/facultad/{id}
        [HttpGet]
        [Route("{id:int}")]
        public IHttpActionResult Get(int id)
        {
            var facultad = oX.consultarFacultad(id);
            if (facultad == null)
            {
                return NotFound();
            }

            return Ok(new ResponseModel
            {
                Exitoso = true,
                Mensaje = "Facultad encontrada",
                Data = facultad
            });
        }

        // POST: api/facultad
        [HttpPost]
        [Route("")]
        public IHttpActionResult Post([FromBody] tblFacultad facultad)
        {
            var resultado = oX.agregarFacultad(facultad);
            return Ok(resultado);
        }

        // PUT: api/facultad
        [HttpPut]
        [Route("")]
        public IHttpActionResult Put([FromBody] tblFacultad facultad)
        {
            var resultado = oX.actualizarFacultad(facultad);
            return Ok(resultado);
        }

        // DELETE: api/facultad/{id}
        [HttpDelete]
        [Route("{id:int}")]
        public IHttpActionResult Delete(int id)
        {
            var resultado = oX.eliminarFacultad(id);
            return Ok(resultado);
        }
    }
}
