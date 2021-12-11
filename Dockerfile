FROM openjdk:17.0.1-slim-buster AS build
LABEL Arthur Vaverko <ArthurVaverko@gmail.com>
WORKDIR /opt/minecraft
COPY . .

# Set memory size
ARG memory_size=2G
ENV MEMORYSIZE=$memory_size

# Set Java Flags
ARG java_flags="-Dlog4j2.formatMsgNoLookups=true -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=mcflags.emc.gs -Dcom.mojang.eula.agree=true"
ENV JAVAFLAGS=$java_flags

# Expose minecraft port
EXPOSE 25565/tcp
EXPOSE 25565/udp
EXPOSE 19132/udp

RUN chmod +x ./paper-1.17.1-399.jar
ENTRYPOINT java -jar -Xms$MEMORYSIZE -Xmx$MEMORYSIZE $JAVAFLAGS ./paper-1.17.1-399.jar nogui
