package ec.uteq.sga.secretaria.controller;

import ec.uteq.sga.secretaria.dto.AsignarRolesRequest;
import ec.uteq.sga.secretaria.dto.CambiarEstadoRequest;
import ec.uteq.sga.secretaria.dto.UsuarioRequest;
import ec.uteq.sga.secretaria.service.UsuarioService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/secretario/usuarios")
public class UsuarioController {

    private final UsuarioService service;

    public UsuarioController(UsuarioService service) {
        this.service = service;
    }

    @GetMapping
    public List<Map<String, Object>> listar() {
        return service.listarTodos();
    }

    @GetMapping("/roles")
    public List<Map<String, Object>> roles() {
        return service.listarRoles();
    }

    @GetMapping("/{id}")
    public Map<String, Object> obtener(@PathVariable Long id) {
        return service.obtenerPorId(id);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Map<String, Object> crear(@Valid @RequestBody UsuarioRequest dto) {
        return service.crear(dto);
    }

    @PatchMapping("/{id}/reset-password")
    public Map<String, Object> resetPassword(@PathVariable Long id) {
        return service.resetearPassword(id);
    }

    @PatchMapping("/{id}/estado")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void cambiarEstado(@PathVariable Long id, @Valid @RequestBody CambiarEstadoRequest dto) {
        service.cambiarEstado(id, dto.estado());
    }

    @PatchMapping("/{id}/roles")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void asignarRoles(@PathVariable Long id, @Valid @RequestBody AsignarRolesRequest dto) {
        service.asignarRoles(id, dto.roles());
    }
}
