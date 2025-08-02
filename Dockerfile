FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# === Runtime Stage ===
FROM eclipse-temurin:17-jre

# Create a non-root user
# RUN useradd -m appuser
# USER appuser

# Set ownership and permissions
RUN chown -R appuser:appuser /app && chmod 755 /app/app.jar

# Use non-root user
USER appuser

# Copy built JAR
COPY --from=build /app/target/*.jar /app/app.jar

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl --fail http://localhost:8080/actuator/health || exit 1
  
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
