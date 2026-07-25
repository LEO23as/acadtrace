package ec.uteq.sga.secretaria.grpc;

import ec.edu.uteq.sga.grpc.principal.AnoLectivoProto;
import ec.edu.uteq.sga.grpc.principal.AsignaturaProto;
import ec.edu.uteq.sga.grpc.principal.Empty;
import ec.edu.uteq.sga.grpc.principal.GradoProto;
import ec.edu.uteq.sga.grpc.principal.ListarParalelosRequest;
import ec.edu.uteq.sga.grpc.principal.ParaleloProto;
import ec.edu.uteq.sga.grpc.principal.PrincipalServiceGrpc;
import ec.uteq.sga.secretaria.common.ApiException;
import io.grpc.Metadata;
import io.grpc.StatusRuntimeException;
import io.grpc.stub.MetadataUtils;
import net.devh.boot.grpc.client.inject.GrpcClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Cliente gRPC hacia sga-principal: reemplaza el SQL directo a
 * sga_principal.anos_lectivos/grados/paralelos/asignaturas (catalogo
 * institucional). Mismo patron que AsistenciaGrpcClient/ActividadGrpcClient
 * ya usan en sga-principal para hablar con MICRO-DOCENTE (stub bloqueante +
 * un header de metadata adjuntado antes de cada llamada).
 */
@Component
public class PrincipalGrpcClient {

    private static final Metadata.Key<String> INTERNAL_TOKEN_KEY =
            Metadata.Key.of("internal_token", Metadata.ASCII_STRING_MARSHALLER);

    @GrpcClient("principal-service")
    private PrincipalServiceGrpc.PrincipalServiceBlockingStub stub;

    @Value("${app.grpc.internal-token}")
    private String internalToken;

    private PrincipalServiceGrpc.PrincipalServiceBlockingStub autenticado() {
        Metadata metadata = new Metadata();
        metadata.put(INTERNAL_TOKEN_KEY, internalToken);
        return stub.withInterceptors(MetadataUtils.newAttachHeadersInterceptor(metadata));
    }

    public List<AnoLectivoProto> listarAnosLectivos() {
        try {
            return autenticado().listarAnosLectivos(Empty.newBuilder().build()).getAnosLectivosList();
        } catch (StatusRuntimeException e) {
            throw ApiException.badGateway("No se pudo consultar años lectivos en sga-principal: " + e.getStatus());
        }
    }

    public List<GradoProto> listarGrados() {
        try {
            return autenticado().listarGrados(Empty.newBuilder().build()).getGradosList();
        } catch (StatusRuntimeException e) {
            throw ApiException.badGateway("No se pudo consultar grados en sga-principal: " + e.getStatus());
        }
    }

    public List<ParaleloProto> listarParalelos(Long idGrado) {
        try {
            ListarParalelosRequest request = ListarParalelosRequest.newBuilder()
                    .setIdGrado(idGrado != null ? idGrado : 0)
                    .build();
            return autenticado().listarParalelos(request).getParalelosList();
        } catch (StatusRuntimeException e) {
            throw ApiException.badGateway("No se pudo consultar paralelos en sga-principal: " + e.getStatus());
        }
    }

    public List<AsignaturaProto> listarAsignaturas() {
        try {
            return autenticado().listarAsignaturas(Empty.newBuilder().build()).getAsignaturasList();
        } catch (StatusRuntimeException e) {
            throw ApiException.badGateway("No se pudo consultar asignaturas en sga-principal: " + e.getStatus());
        }
    }
}
