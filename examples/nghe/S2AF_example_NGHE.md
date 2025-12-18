# S2AF Case Study — Next Generation Heavy Equipment (NGHE)

This case study demonstrates the application of `S2AF — SysML v2 Aligned Architecture Framework` to the Next Generation Heavy Equipment (NGHE) domain. The architecture is organized around four core analytical capabilities, with SysML v2 artifacts systematically distributed across the S2AF grid (Domain × Concern):

1) Worksite Area Analysis
2) Equipment Performance Requirements Analysis
3) Autonomy/Teleoperation Analysis
4) Safety Analysis

Reference: For framework overview, see `docs/S2AF.md`; for integrated grid structure, see `docs/S2AF_grid.md`; for process guidance, see `docs/S2AF_process.md`.

---

## 0. Scope and Key Questions (P0)

- **Stakeholders**: Site Manager, Equipment Operator, Tele-operator, Safety Manager, Maintenance/Quality, System Engineer, Project Manager
- **Key Questions**
  - Which capabilities, services, and resources directly improve worksite productivity and safety?
  - How are equipment performance requirements (cycle time, energy efficiency, availability) derived and verified?
  - What are the latency/reliability/availability targets for autonomy/teleoperation, and how are they reflected in equipment/network design?
  - How are safety requirements (stopping distance, detection-to-stop delay, risk reduction) and standards compliance demonstrated?
- **Priority Cells**: Strategy—Static/Dynamic/Contracts, Operational—Static/Dynamic, Service—All concerns, Resource—All concerns, Project—Contracts

---

## 1. Strategy Domain (Why)

- **Capability Taxonomy (Definition)**
  - NGHE Core Capability
    - C1: Worksite Area Analysis
    - C2: Equipment Performance Requirements Analysis
    - C3: Autonomy/Teleoperation Analysis
    - C4: Safety Analysis
- **Mission Thread (Activity/Interaction)**
  - Worksite analysis → Performance requirement derivation → Work planning/allocation → Autonomy/teleoperation execution → Safety monitoring/response → Performance evaluation/replanning
- **KPIs (Data Definition)** Examples
  - Productivity: m³/h or ton/h ≥ target
  - Cycle Time (load→travel→dump): p95 ≤ target
  - Energy Efficiency: kWh/ton or L/ton ≤ target
  - Availability ≥ 0.97, MTBF ≥ target
  - Teleoperation latency p95 ≤ 150 ms, packet loss ≤ 1%
  - Safety: collisions = 0, near-miss rate ≤ threshold, detection-to-stop time ≤ 100 ms
- **Constraints (Parametric)** Examples
  - cycle_time_total = t_load + t_travel + t_dump ≤ CT_target
  - energy_per_ton = energy_used / ton_moved ≤ E_target
  - teleop_latency_p95 ≤ 150 ms, link_availability ≥ 0.999
  - stopping_distance ≥ f(vehicle_speed, brake_delay, surface_μ)
  - detection_to_stop_time = perception_delay + control_delay + brake_delay ≤ 100 ms
- **Roadmap (Table)**

| Capability | R1 | R2 | R3 |
|:--|:--:|:--:|:--:|
| C1 Worksite Area Analysis | ✓ (Basic Mapping) | Real-time Update | Digital Twin Integration |
| C2 Performance Requirements Analysis | Baseline Derivation | Data-driven Calibration | Adaptive Optimization |
| C3 Autonomy/Teleoperation Analysis | Remote Pilot | Autonomy Assist | ✓ (Autonomous Operation) |
| C4 Safety Analysis | Baseline/HAZOP | SOTIF/Case Enrichment | ✓ (Advanced & Audited) |

---

## 2. Operational Domain (What)

- **Performers (Definition/Structure)**
  - Equipment (excavator, loader, dump truck, etc.), Remote Operator, Site/Safety Manager, Fleet Management System, Edge Gateway, Sensor Network
  - Information Exchange (Needlines): Telemetry, Tasking, Route/Plan, Safety/Stop signals, Maintenance alerts
- **Operational Activities (Activity)**
  - OA1: Worksite Data Collection/Mapping (terrain/obstacles/work zones)
  - OA2: Performance Requirement Analysis/Verification (cycle time, energy, availability)
  - OA3: Work Planning/Allocation and Autonomy/Teleoperation Execution
  - OA4: Safety Monitoring/Risk Response (E-Stop/deceleration/avoidance)
  - OA5: Performance Analysis/Maintenance Planning/Replanning
- **Operational Interactions (Interaction)**
  - Fleet Management ↔ Equipment ↔ Remote Operator: planning/status/safety alert message sequences
- **Business Rules (Parametric)**
  - If visibility < θ or human detected → decelerate/stop; If slope > φ_thr → speed limit; If communication quality < q_thr → remote→local safe transition
- **Information Structure (Data Definition)**
  - Messages: Map, Tasking, Route, Telemetry, SafetyAlert, Maintenance

---

## 3. Service Domain (How-as-a-Service)

- **Service Specifications (Definition/Structure)**
  - S1 WorksiteAnalysisService: Worksite model/update, risk area identification
  - S2 PerfReqService: Performance requirement derivation/monitoring/calibration
  - S3 AutonomyTeleopService: Autonomy assist/path planning/teleoperation HIL
  - S4 SafetyAssuranceService: Detection/alert/E-Stop/safety logging
- **Behavior/Orchestration (Activity/Interaction)**
  - Service interaction sequence: Worksite→PerfReq→Autonomy/Teleop→Safety
- **Data/Protocol (Data Definition)**
  - NGHE-MSG v1 (map/work/route/telemetry/safety), gRPC/REST, industrial fieldbus/ROS2 integration
- **SLA/Policy (Parametric/Table)**

| Service | Latency p95 | Availability | Policy/Security |
|:--|:--:|:--:|:--|
| S1 Worksite | ≤ 1.0 s | ≥ 99.5% | Data lineage, consistency checks |
| S2 PerfReq | ≤ 2.0 s | ≥ 99.5% | Baseline/calibration history management |
| S3 Autonomy/Teleop | ≤ 150 ms | ≥ 99.9% | RBAC, control audit logs |
| S4 Safety | ≤ 100 ms | ≥ 99.99% | Encryption, redundancy, immutable logs |

---

## 4. Resource Domain (With What)

- **System/Configuration (Definition/Structure)**
  - Equipment Platform: Powertrain, work attachment, autonomy/teleoperation module, safety H/W (E-Stop, HSM)
  - Sensors: LiDAR, radar, cameras, ultrasonic, IMU, GNSS/RTK
  - Communications: 5G/private radio/Wi-Fi 6, V2X, industrial bus
  - Computing: Edge (on-equipment), site server, cloud analytics
- **Event Trace/State (Interaction/StateMachine)**
  - States: {Manual, Assist, Autonomous, Teleoperation, Safety Stop} transitions; safe transition logic on communication failure
- **Data Models (Data Definition)**
  - Physical/Logical: Telemetry, Map, Route, Tasking, SafetyEvent, Maintenance
- **Performance/Standards/Constraints (Parametric/Table)**

| Resource | Throughput/Performance | Link | Encryption | Standards/Specifications |
|:--|:--:|:--:|:--:|:--|
| Equipment Computing | ≥ 10 TOPS | 5G/private radio | AES-256/GCM | IEC 61508 (concept), ISO 13849 (concept) |
| Edge/Site Server | ≥ 5k msg/s | Wired/wireless hybrid | TLS1.3 | ISO 27001 |
| Sensor Network | ≥ 1Gbps | TSN/Ethernet | MACsec (optional) | Industrial safety/EMC general |

---

## 5. Project Domain (When)

- **WBS/Decomposition (Definition)**: 
  - W1 Worksite Analysis, W2 Performance Requirements Analysis, W3 Autonomy/Teleoperation Module, W4 Safety Assurance, W5 Integration/Test/Certification
- **Workflow/Dependencies (Activity)**: W1→W2→W3, W4 in parallel, W5 integration followed by verification/certification
- **Milestones (Table)**

| Milestone | Schedule | Deliverables |
|:--|:--:|:--|
| M1 | R1 | C1 basic, S1 draft, resource baseline |
| M2 | R2 | C2 refined, S2/3 pilot, safety logic v1 |
| M3 | R3 | C3/4 operational, SLA/safety advanced, certification package |

---

## 6. Grid Mapping

| Domain/Concern | Static (Definition/Structure) | Dynamic (Activity/Interaction/State) | Contracts (Data/Parametric/Table) |
|:--|:--|:--|:--|
| Strategy (Why) | C1~C4 capability tree/usage decomposition | Mission thread (worksite→safety) | KPI/constraints/roadmap tables |
| Operational (What) | Performers/ports/needlines | OA1~OA5 activities/sequences | Business rules constraints, information schema |
| Service (How) | S1~S4 service specs/ports | Orchestration sequences | SLA/policy matrix |
| Resource (With What) | Equipment/sensor/comms/computing structure | State machines/events | Performance/standards/security constraints |
| Project (When) | WBS/W1~W5 | Workflow/dependencies | Milestone/traceability tables |

---

## 7. Traceability (Table)

- **Capability ↔ Service**

| Capability | Services |
|:--|:--|
| C1 Worksite Area Analysis | S1 WorksiteAnalysis |
| C2 Performance Requirements Analysis | S2 PerfReq |
| C3 Autonomy/Teleoperation Analysis | S3 AutonomyTeleop |
| C4 Safety Analysis | S4 SafetyAssurance |

- **Service ↔ Resource**

| Service | Resource Bindings |
|:--|:--|
| S1 | Sensor Network, Edge/Site Server |
| S2 | Edge/Site Server, Cloud Analytics |
| S3 | Equipment Computing, Communications |
| S4 | Sensor Network, Communications |

- **Capability/Service ↔ Milestone**

| Item | M1 | M2 | M3 |
|:--|:--:|:--:|:--:|
| C1/S1 | ✓ | upd | upd |
| C2/S2 |  | ✓ | upd |
| C3/S3 |  | pilot | ✓ |
| C4/S4 |  | v1 | ✓ |

---

## 8. Quality Gates (Excerpt)

- Parametric verification cases for KPIs/constraints (cycle time/latency/stop time) exist and pass
- Evidence of service SLA p95 latency, availability, and security policy compliance (logs/reports)
- End-to-end traceability links from capability→operational→service→resource→project complete and auditable

---

## 9. Artifacts (SysML v2 Views)

- Definition: Capability tree (C1~C4), performer/service types
- Structure (Usage): Equipment/sensor/comms/computing internal structure, ports/connectors
- Activity: Mission flows, operational activities, approval/safety workflows
- Interaction: Work/teleoperation/safety sequences, event traces
- State Machine: Operational mode/safety transitions, link/equipment state transitions
- Data Definition: Map/work/route/telemetry/safety/maintenance schemas
- Parametric: Performance/energy/latency/stopping distance constraint models
- Table: Roadmap/milestone/traceability matrices

---

## 10. SysML Views

- **Capability Tree (Definition)**
```mermaid
classDiagram
class Capability
class C1_WorksiteAreaAnalysis
class C2_EquipmentPerformanceRequirementsAnalysis
class C3_AutonomyTeleoperationAnalysis
class C4_SafetyAnalysis
Capability <|-- C1_WorksiteAreaAnalysis
Capability <|-- C2_EquipmentPerformanceRequirementsAnalysis
Capability <|-- C3_AutonomyTeleoperationAnalysis
Capability <|-- C4_SafetyAnalysis
```

- **Mission Thread (Sequence / Activity)**
```mermaid
sequenceDiagram
autonumber
participant Worksite as MT_WorksiteAnalysis
participant PerfReq as MT_PerfRequirementDerivation
participant Planning as MT_PlanningAllocation
participant AutoTeleop as MT_AutonomyTeleopExecution
participant Safety as MT_SafetyMonitoringEvaluation
Worksite->>PerfReq: WorksiteMissionData
PerfReq->>Planning: WorksiteMissionData
Planning->>AutoTeleop: WorksiteMissionData
AutoTeleop->>Safety: WorksiteMissionData
Note over Worksite,Safety: Mission Thread: Worksite Analysis → Performance Derivation → Planning → Execution → Safety Evaluation
```

- **Operational Mode State Machine (State Machine)**
```mermaid
stateDiagram-v2
state "E-Stop" as EStop
[*] --> Manual
Manual --> Assist: Enable Assist
Assist --> Autonomous: Enable Auto
Autonomous --> Teleoperation: Operator Takeover
Teleoperation --> Autonomous: Resume Auto
Manual --> EStop: Emergency Stop
Assist --> EStop: Emergency Stop
Autonomous --> EStop: Emergency Stop
Teleoperation --> EStop: Emergency Stop
EStop --> Manual: Reset from E-Stop
```

- **Service Orchestration (Sequence)**
```mermaid
sequenceDiagram
autonumber
participant S1 as S1_WorksiteAnalysisService
participant S2 as S2_PerfReqService
participant S3 as S3_AutonomyTeleopService
participant S4 as S4_SafetyAssuranceService
S1->>S2: SO_WorksiteToPerfReq (Worksite Model)
S2->>S3: SO_PerfReqToAutoTeleop (Performance Targets)
S3->>S4: SO_AutoTeleopToSafety (Telemetry/Events)
S4->>S3: SO_SafetyToAutoTeleop (Safety Ack/E-Stop)
Note over S1,S4: Service Orchestration: Worksite → PerfReq → AutoTeleop ↔ Safety
```

- **Operational Performer Structure (Definition)**
```mermaid
graph LR
  equipment[Equipment]
  remote[Remote Operator]
  site[Site/Safety Manager]
  fleet[Fleet Management System]
  edge[Edge Gateway]
  sensor[Sensor Network]
  nlTel((Telemetry))
  nlTask((Tasking))
  nlRoute((Route/Plan))
  nlSafety((Safety/Stop))
  nlMaint((Maintenance))
  equipment --- nlTel
  fleet --- nlTel
  edge --- nlTel
  fleet --- nlTask
  equipment --- nlTask
  remote --- nlTask
  fleet --- nlRoute
  equipment --- nlRoute
  equipment --- nlSafety
  site --- nlSafety
  remote --- nlSafety
  equipment --- nlMaint
  fleet --- nlMaint
```

- **Service Catalog (Definition)**
```mermaid
classDiagram
class S1_WorksiteAnalysisService {
  +Provided: WorksiteProvided
  +Required: MapInputRequired
}
class S2_PerfReqService {
  +Provided: PerfTargetsProvided
  +Required: WorksiteModelRequired
}
class S3_AutonomyTeleopService {
  +Provided: AutoTeleopProvided
  +Required: PerfTargetsRequired
}
class S4_SafetyAssuranceService {
  +Provided: SafetyProvided
  +Required: TelemetryEventsRequired
}
```

- **Resource System Configuration (Definition)**
```mermaid
classDiagram
class EquipmentComputing
class EdgeServer
class CloudAnalytics
class SensorNetwork
class Communications
```

- **Project Workflow (Activity)**
```mermaid
flowchart LR
  W1["W1 Worksite Analysis"] --> W2["W2 Performance Requirements Analysis"] --> W3["W3 Autonomy/Teleop Module"] --> W5["W5 Integration/Test/Certification"]
  W4["W4 Safety Assurance Module"] --> W5
```

- **Strategy Contracts (KPI/Constraints Overview)**
```mermaid
classDiagram
class KPI_Productivity
class KPI_CycleTime
class KPI_EnergyEfficiency
class KPI_Availability
class KPI_TeleopLatency
class KPI_SafetyResponse
class CycleTimeConstraint
class EnergyPerTonConstraint
class TeleopLatencyConstraint
class StoppingDistanceConstraint
class DetectionToStopConstraint
```

- **Operational Interaction (Sequence)**
```mermaid
sequenceDiagram
autonumber
participant Fleet as FleetManagementSystem
participant Equip as Equipment
participant Remote as RemoteOperator
participant Site as SiteManager
Fleet->>Equip: MSG_Tasking
Fleet->>Equip: MSG_Route
Equip-->>Fleet: MSG_Telemetry
Site-->>Equip: MSG_SafetyAlert (E-Stop)
Remote-->>Equip: MSG_Tasking
Equip-->>Fleet: MSG_Maintenance
```

- **Operational Information Items (Definition)**
```mermaid
classDiagram
class MSG_Map
class MSG_Tasking
class MSG_Route
class MSG_Telemetry
class MSG_SafetyAlert
class MSG_Maintenance
```

- **Resource Contracts (Data Models / Standards / Performance)**
```mermaid
classDiagram
class DM_Telemetry
class DM_Map
class DM_Route
class DM_Tasking
class DM_SafetyEvent
class DM_Maintenance
class STD_EquipmentComputing
class STD_EdgeServer
class STD_SensorNetwork
class PERF_EquipmentComputing
class PERF_EdgeServer
class PERF_SensorNetwork
```

- **Project Structure (Definition)**
```mermaid
classDiagram
class W1_WorksiteAnalysis
class W2_PerfReqAnalysis
class W3_AutonomyTeleopModule
class W4_SafetyAssuranceModule
class W5_IntegrationTestCertification
```

- **Operational Business Rules (Definition)**
```mermaid
classDiagram
class BR_VisibilitySafety
class BR_SlopeSpeedLimit
class BR_CommsSafeTransition
```

- **Service Contracts (API / SLA)**
```mermaid
classDiagram
class NGHE_MSG_Schema
class SLA_S1_Worksite
class SLA_S2_PerfReq
class SLA_S3_AutoTeleop
class SLA_S4_Safety
```

- **Project Contracts (Milestones / DoD)**
```mermaid
classDiagram
class M1_Milestone
class M2_Milestone
class M3_Milestone
class DoD_M1
class DoD_M2
class DoD_M3
```
