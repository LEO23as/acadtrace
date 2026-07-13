# Protos gRPC (pendiente)

Carpeta destino para el `.proto` que definirá sga-principal para exponer
lectura/escritura de estudiantes, matrículas y usuarios por gRPC.

Una vez llegue el archivo:
1. Colocarlo aquí (`backend/src/main/proto/*.proto`).
2. `./mvnw generate-sources` genera los stubs Java en `target/generated-sources`.
3. Implementar el cliente gRPC (canal + stub) y reemplazar las consultas SQL
   directas a `sga_principal.*` en los `*Service` por llamadas al stub.

El `protobuf-maven-plugin` y las dependencias de `grpc-java` ya están
configuradas en `pom.xml`.
