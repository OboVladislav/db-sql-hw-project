FROM postgres:17

WORKDIR /workspace

COPY booking_hotel_db ./booking_hotel_db
COPY organization_structure_db ./organization_structure_db
COPY transport_vehicle_db ./transport_vehicle_db
COPY vehicle_races_db ./vehicle_races_db
COPY runner ./runner

RUN sed -i 's/\r$//' /workspace/runner/run_all.sh && chmod +x /workspace/runner/run_all.sh && cat -A /workspace/runner/run_all.sh