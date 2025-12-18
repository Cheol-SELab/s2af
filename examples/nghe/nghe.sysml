/**
 * NGHE (Next Generation Heavy Equipment) Architecture Model
 * Based on S2AF (SysML v2 Aligned Architecture Framework)
 * 
 * This model defines the NGHE system architecture following the S2AF grid structure:
 * - Strategy Domain (Why): Capabilities, Mission Threads, KPIs
 * - Operational Domain (What): Performers, Activities, Information Exchange
 * - Service Domain (How): Service Specifications, Orchestration, SLAs
 * - Resource Domain (With What): Systems, Configurations, Standards
 * - Project Domain (When): WBS, Workflows, Milestones
 */

package NGHE {
  private import ScalarValues::String;
  private import ScalarValues::Integer;
  private import ScalarValues::Real;
  private import ScalarValues::Boolean;
  private import Base::Anything;
  private import Connections::BinaryConnection;
  private import Allocations::Allocation;
  
  private import Level1BaseTypes::*;
  private import Level2DomainTypes::*;
  private import Level3ArchitectureTypes::*;
  private import S2AFBaseTypes::*;
  private import S2AFGridCellArtifacts::*;
  private import S2AFGridModel::*;

  // ============================================================================
  // P0. SCOPING & QUESTION COLLECTION
  // ============================================================================
  
  package P0_Scoping {
    doc /* Stakeholders: Site Manager, Equipment Operator, Tele-operator,
           Safety Manager, Maintenance/Quality, System Engineer, PM
           
           Key Questions:
           - Which capabilities, services, and resources directly improve worksite productivity and safety?
           - How are equipment performance requirements (cycle time, energy efficiency, availability) derived and verified?
           - What are the latency/reliability/availability targets for autonomy/teleoperation and how are they reflected in design?
           - How are safety requirements (stopping distance, detection-to-stop delay, risk reduction) and standards compliance demonstrated? */
    
    part def NGHEStakeholder :> Organization {
      attribute role : String;
    }
    
    part siteManager : NGHEStakeholder {
      attribute :>> id = "STK-N-001";
      attribute :>> name = "Site Manager";
      attribute :>> description = "Responsible for worksite productivity and coordination";
      attribute :>> role = "Operations";
    }
    
    part equipmentOperator : NGHEStakeholder {
      attribute :>> id = "STK-N-002";
      attribute :>> name = "Equipment Operator";
      attribute :>> description = "Operates heavy equipment on site";
      attribute :>> role = "Operations";
    }
    
    part teleOperator : NGHEStakeholder {
      attribute :>> id = "STK-N-003";
      attribute :>> name = "Tele-operator";
      attribute :>> description = "Remote operator for teleoperation";
      attribute :>> role = "Teleoperation";
    }
    
    part safetyManager : NGHEStakeholder {
      attribute :>> id = "STK-N-004";
      attribute :>> name = "Safety Manager";
      attribute :>> description = "Responsible for safety monitoring and compliance";
      attribute :>> role = "Safety";
    }
    
    part maintQuality : NGHEStakeholder {
      attribute :>> id = "STK-N-005";
      attribute :>> name = "Maintenance/Quality";
      attribute :>> description = "Maintenance planning and quality assurance";
      attribute :>> role = "Maintenance";
    }
    
    part systemEngineer : NGHEStakeholder {
      attribute :>> id = "STK-N-006";
      attribute :>> name = "System Engineer";
      attribute :>> description = "System design and integration for NGHE";
      attribute :>> role = "Engineering";
    }
    
    part projectManager : NGHEStakeholder {
      attribute :>> id = "STK-N-007";
      attribute :>> name = "Project Manager";
      attribute :>> description = "Project schedule and delivery management";
      attribute :>> role = "Management";
    }
  }

  // ============================================================================
  // P1. STRATEGY DOMAIN (WHY)
  // ============================================================================
  
  package P1_Strategy {
    
    // ---------- Static: Capability Taxonomy (Definition) ----------
    
    action def NGHECoreCapability :> Capability {
      doc /* Root capability for NGHE system */
    }
    
    action def C1_WorksiteAreaAnalysis :> Capability {
      doc /* Worksite Area Analysis capability
             Provides worksite modeling and risk area identification */
      attribute :>> id = "NGHE-CAP-C1";
      attribute :>> name = "Worksite Area Analysis";
      attribute :>> description = "Worksite data collection, mapping, and risk area analysis";
    }
    
    action def C2_EquipmentPerformanceRequirementsAnalysis :> Capability {
      doc /* Equipment Performance Requirements Analysis capability
             Provides performance requirement derivation and monitoring */
      attribute :>> id = "NGHE-CAP-C2";
      attribute :>> name = "Equipment Performance Requirements Analysis";
      attribute :>> description = "Derive and validate equipment performance requirements (cycle time, energy, availability)";
    }
    
    action def C3_AutonomyTeleoperationAnalysis :> Capability {
      doc /* Autonomy/Teleoperation Analysis capability
             Provides autonomy and teleoperation performance analysis */
      attribute :>> id = "NGHE-CAP-C3";
      attribute :>> name = "Autonomy/Teleoperation Analysis";
      attribute :>> description = "Analyze and design autonomy/teleoperation latency, reliability, and availability";
    }
    
    action def C4_SafetyAnalysis :> Capability {
      doc /* Safety Analysis capability
             Provides safety requirement analysis and compliance evidence */
      attribute :>> id = "NGHE-CAP-C4";
      attribute :>> name = "Safety Analysis";
      attribute :>> description = "Analyze safety requirements, stopping distance, and standards compliance";
    }
    
    part ngheCapabilityTree : CapabilityTaxonomy {
      attribute :>> id = "NGHE-CAP-TREE";
      attribute :>> name = "NGHE Capability Tree";
      attribute :>> description = "Hierarchical decomposition of NGHE capabilities";
      attribute :>> domainType = DomainKind::Strategy;
      attribute :>> concernType = ConcernKind::Static;
      attribute :>> stakeholderQuestion = "What capabilities exist and how are they organized for NGHE?";
      
      action c1 : C1_WorksiteAreaAnalysis;
      action c2 : C2_EquipmentPerformanceRequirementsAnalysis;
      action c3 : C3_AutonomyTeleoperationAnalysis;
      action c4 : C4_SafetyAnalysis;
    }
    
    // ---------- Dynamic: Mission Thread (Activity/Interaction) ----------
    
    action def NGHEMissionThread :> Mission {
      doc /* Main mission thread: Worksite analysis → PerfReq derivation → Planning/Allocation → Autonomy/Teleop execution → Safety monitoring/response → Performance evaluation/replanning */
      attribute :>> id = "NGHE-MSN-001";
      attribute :>> name = "NGHE Mission Thread";
      attribute :>> description = "End-to-end NGHE mission flow from worksite analysis to evaluation";
    }
    
    item def WorksiteMissionData;
    
    action def MT_WorksiteAnalysis :> OperationalTask {
      in input : WorksiteMissionData;
      out output : WorksiteMissionData;
      attribute :>> id = "NGHE-MT-001";
      attribute :>> name = "Worksite Analysis";
      attribute :>> description = "Collect and analyze worksite area data";
    }
    
    action def MT_PerfRequirementDerivation :> OperationalTask {
      in input : WorksiteMissionData;
      out output : WorksiteMissionData;
      attribute :>> id = "NGHE-MT-002";
      attribute :>> name = "Performance Requirement Derivation";
      attribute :>> description = "Derive and set performance requirements (cycle time, energy, availability)";
    }
    
    action def MT_PlanningAllocation :> OperationalTask {
      in input : WorksiteMissionData;
      out output : WorksiteMissionData;
      attribute :>> id = "NGHE-MT-003";
      attribute :>> name = "Planning and Allocation";
      attribute :>> description = "Plan and allocate work tasks to equipment";
    }
    
    action def MT_AutonomyTeleopExecution :> OperationalTask {
      in input : WorksiteMissionData;
      out output : WorksiteMissionData;
      attribute :>> id = "NGHE-MT-004";
      attribute :>> name = "Autonomy/Teleoperation Execution";
      attribute :>> description = "Execute work using autonomy/teleoperation";
    }
    
    action def MT_SafetyMonitoringEvaluation :> OperationalTask {
      in input : WorksiteMissionData;
      out output : WorksiteMissionData;
      attribute :>> id = "NGHE-MT-005";
      attribute :>> name = "Safety Monitoring and Evaluation";
      attribute :>> description = "Monitor safety, respond to hazards, and evaluate performance";
    }
    
    part ngheMissionFlow : CapabilityRealizationFlow {
      attribute :>> id = "NGHE-MSN-FLOW";
      attribute :>> name = "NGHE Mission Realization Flow";
      attribute :>> description = "Mission thread from worksite analysis to evaluation";
      attribute :>> domainType = DomainKind::Strategy;
      attribute :>> concernType = ConcernKind::Dynamic;
      attribute :>> stakeholderQuestion = "How are NGHE capabilities realized through mission threads?";
      
      action missionThread : NGHEMissionThread;
      action worksiteAnalysis : MT_WorksiteAnalysis;
      action perfDerivation : MT_PerfRequirementDerivation;
      action planningAllocation : MT_PlanningAllocation;
      action autoTeleop : MT_AutonomyTeleopExecution;
      action safetyEval : MT_SafetyMonitoringEvaluation;
      
      // Flow: worksiteAnalysis → perfDerivation → planningAllocation → autoTeleop → safetyEval
      flow from worksiteAnalysis.output to perfDerivation.input;
      flow from perfDerivation.output to planningAllocation.input;
      flow from planningAllocation.output to autoTeleop.input;
      flow from autoTeleop.output to safetyEval.input;
    }
    
    // ---------- Contracts: KPIs and Constraints (Data Definition/Parametric) ----------
    
    part def KPI_Productivity :> VerificationCriterion {
      doc /* Productivity KPI (m^3/h or ton/h) */
      attribute :>> id = "NGHE-KPI-001";
      attribute :>> name = "Productivity";
      attribute :>> description = "Productivity (m^3/h or ton/h) ≥ target";
      attribute target : Real;
    }
    
    part def KPI_CycleTime :> VerificationCriterion {
      doc /* Cycle time KPI */
      attribute :>> id = "NGHE-KPI-002";
      attribute :>> name = "Cycle Time";
      attribute :>> description = "Cycle time (load→travel→dump) p95 ≤ CT_target";
      attribute ctTarget : Real;
    }
    
    part def KPI_EnergyEfficiency :> VerificationCriterion {
      doc /* Energy efficiency KPI */
      attribute :>> id = "NGHE-KPI-003";
      attribute :>> name = "Energy Efficiency";
      attribute :>> description = "Energy per ton (kWh/ton or L/ton) ≤ target";
      attribute energyTarget : Real;
    }
    
    part def KPI_Availability :> VerificationCriterion {
      doc /* Availability KPI */
      attribute :>> id = "NGHE-KPI-004";
      attribute :>> name = "Availability";
      attribute :>> description = "Availability ≥ 0.97, MTBF ≥ target";
      attribute availabilityTarget : Real = 0.97;
    }
    
    part def KPI_TeleopLatency :> VerificationCriterion {
      doc /* Teleoperation latency KPI */
      attribute :>> id = "NGHE-KPI-005";
      attribute :>> name = "Teleoperation Latency";
      attribute :>> description = "Teleoperation p95 latency ≤ 150 ms, packet loss ≤ 1%";
      attribute latencyP95Target : Real = 150.0;
    }
    
    part def KPI_SafetyResponse :> VerificationCriterion {
      doc /* Safety response KPI */
      attribute :>> id = "NGHE-KPI-006";
      attribute :>> name = "Safety Response";
      attribute :>> description = "Detection-to-stop time ≤ 100 ms, collisions 0, near-miss rate ≤ threshold";
      attribute stopTimeTarget : Real = 100.0;
    }
    
    constraint def CycleTimeConstraint {
      doc /* cycle_time_total = t_load + t_travel + t_dump ≤ CT_target */
      attribute t_load : Real;
      attribute t_travel : Real;
      attribute t_dump : Real;
      attribute CT_target : Real;
      attribute cycle_time_total : Real = t_load + t_travel + t_dump;
      constraint { cycle_time_total <= CT_target }
    }
    
    constraint def EnergyPerTonConstraint {
      doc /* energy_per_ton = energy_used / ton_moved ≤ E_target */
      attribute energy_used : Real;
      attribute ton_moved : Real;
      attribute E_target : Real;
      attribute energy_per_ton : Real = energy_used / ton_moved;
      constraint { energy_per_ton <= E_target }
    }
    
    constraint def TeleopLatencyConstraint {
      doc /* teleop_latency_p95 ≤ 150 ms, link_availability ≥ 0.999 */
      attribute teleop_latency_p95 : Real;
      attribute link_availability : Real;
      constraint { teleop_latency_p95 <= 150.0 }
      constraint { link_availability >= 0.999 }
    }
    
    constraint def StoppingDistanceConstraint {
      doc /* stopping_distance ≥ f(vehicle_speed, brake_delay, surface_mu) */
      attribute vehicle_speed : Real;
      attribute brake_delay : Real;
      attribute surface_mu : Real;
      attribute stopping_distance : Real;
    }
    
    constraint def DetectionToStopConstraint {
      doc /* detection_to_stop_time = perception_delay + control_delay + brake_delay ≤ 100 ms */
      attribute perception_delay : Real;
      attribute control_delay : Real;
      attribute brake_delay : Real;
      attribute detection_to_stop_time : Real = perception_delay + control_delay + brake_delay;
      constraint { detection_to_stop_time <= 100.0 }
    }
    
    part ngheCapabilityContract : CapabilityContract {
      attribute :>> id = "NGHE-CAP-CONTRACT";
      attribute :>> name = "NGHE Capability Contract";
      attribute :>> description = "KPIs and constraints for NGHE capabilities";
      attribute :>> domainType = DomainKind::Strategy;
      attribute :>> concernType = ConcernKind::Contracts;
      attribute :>> stakeholderQuestion = "How are NGHE capabilities measured and validated?";
      
      part kpiProductivity : KPI_Productivity;
      part kpiCycleTime : KPI_CycleTime;
      part kpiEnergy : KPI_EnergyEfficiency;
      part kpiAvailability : KPI_Availability;
      part kpiTeleopLatency : KPI_TeleopLatency;
      part kpiSafety : KPI_SafetyResponse;
    }
    
    part def NGHECapabilityRoadmapEntry {
      attribute capability : String;
      attribute r1Status : String;
      attribute r2Status : String;
      attribute r3Status : String;
    }
    
    part c1Roadmap : NGHECapabilityRoadmapEntry {
      attribute :>> capability = "C1 Worksite Area Analysis";
      attribute :>> r1Status = "Basic Mapping";
      attribute :>> r2Status = "Real-time Update";
      attribute :>> r3Status = "Digital Twin Integration";
    }
    
    part c2Roadmap : NGHECapabilityRoadmapEntry {
      attribute :>> capability = "C2 Equipment Performance Requirements Analysis";
      attribute :>> r1Status = "Baseline Derivation";
      attribute :>> r2Status = "Data-driven Calibration";
      attribute :>> r3Status = "Adaptive Optimization";
    }
    
    part c3Roadmap : NGHECapabilityRoadmapEntry {
      attribute :>> capability = "C3 Autonomy/Teleoperation Analysis";
      attribute :>> r1Status = "Remote Pilot";
      attribute :>> r2Status = "Autonomy Assist";
      attribute :>> r3Status = "Autonomous Operation";
    }
    
    part c4Roadmap : NGHECapabilityRoadmapEntry {
      attribute :>> capability = "C4 Safety Analysis";
      attribute :>> r1Status = "Baseline/HAZOP";
      attribute :>> r2Status = "SOTIF/Case Enrichment";
      attribute :>> r3Status = "Advanced & Audited";
    }
  }

  // ============================================================================
  // P2. OPERATIONAL DOMAIN (WHAT)
  // ============================================================================
  
  package P2_Operational {
    
    // ---------- Static: Performer Structure (Definition/Structure) ----------
    
    part def EquipmentPerformer :> Performer {
      doc /* Heavy equipment performer (excavator, loader, dump truck, etc.) */
      attribute :>> id = "NGHE-PFM-001";
      attribute :>> name = "Equipment";
      attribute :>> description = "Heavy equipment such as excavator, loader, dump truck";
    }
    
    part def RemoteOperator :> Performer {
      doc /* Remote operator for teleoperation */
      attribute :>> id = "NGHE-PFM-002";
      attribute :>> name = "Remote Operator";
      attribute :>> description = "Tele-operator controlling equipment remotely";
    }
    
    part def SiteManagerPerformer :> Performer {
      doc /* Site manager / safety manager performer */
      attribute :>> id = "NGHE-PFM-003";
      attribute :>> name = "Site/Safety Manager";
      attribute :>> description = "Site and safety management performer";
    }
    
    part def FleetManagementSystem :> Performer {
      doc /* Fleet management system performer */
      attribute :>> id = "NGHE-PFM-004";
      attribute :>> name = "Fleet Management System";
      attribute :>> description = "System managing equipment fleet and tasks";
    }
    
    part def EdgeGatewayPerformer :> Performer {
      doc /* Edge gateway performer */
      attribute :>> id = "NGHE-PFM-005";
      attribute :>> name = "Edge Gateway";
      attribute :>> description = "Edge gateway for local processing";
    }
    
    part def SensorNetworkPerformer :> Performer {
      doc /* Sensor network performer */
      attribute :>> id = "NGHE-PFM-006";
      attribute :>> name = "Sensor Network";
      attribute :>> description = "Sensor network including LiDAR, radar, cameras, etc.";
    }
    
    // Needlines (Information Exchange)
    part def NL_Telemetry :> CommunicationPath {
      attribute :>> id = "NGHE-NL-001";
      attribute :>> name = "Telemetry Needline";
      attribute :>> description = "Telemetry data exchange between equipment and systems";
    }
    
    part def NL_Tasking :> CommunicationPath {
      attribute :>> id = "NGHE-NL-002";
      attribute :>> name = "Tasking Needline";
      attribute :>> description = "Work instructions and tasking";
    }
    
    part def NL_RoutePlan :> CommunicationPath {
      attribute :>> id = "NGHE-NL-003";
      attribute :>> name = "Route/Plan Needline";
      attribute :>> description = "Route and work plan information";
    }
    
    part def NL_SafetyStop :> CommunicationPath {
      attribute :>> id = "NGHE-NL-004";
      attribute :>> name = "Safety/Stop Needline";
      attribute :>> description = "Safety and emergency stop signals";
    }
    
    part def NL_Maintenance :> CommunicationPath {
      attribute :>> id = "NGHE-NL-005";
      attribute :>> name = "Maintenance Needline";
      attribute :>> description = "Maintenance alerts and planning";
    }
    
    part nghePerformerStructure : PerformerStructure {
      attribute :>> id = "NGHE-PFM-STRUCT";
      attribute :>> name = "NGHE Performer Structure";
      attribute :>> description = "Performers and information exchange paths for NGHE";
      attribute :>> domainType = DomainKind::Operational;
      attribute :>> concernType = ConcernKind::Static;
      attribute :>> stakeholderQuestion = "What performers exist and how do they exchange information in NGHE?";
      
      part equipment : EquipmentPerformer;
      part remoteOperator : RemoteOperator;
      part siteManager : SiteManagerPerformer;
      part fleetSystem : FleetManagementSystem;
      part edgeGateway : EdgeGatewayPerformer;
      part sensorNetwork : SensorNetworkPerformer;
      
      part nlTelemetry : NL_Telemetry;
      part nlTasking : NL_Tasking;
      part nlRoutePlan : NL_RoutePlan;
      part nlSafetyStop : NL_SafetyStop;
      part nlMaintenance : NL_Maintenance;
    }
    
    // ---------- Dynamic: Operational Activities (Activity/Interaction) ----------
    
    action def OA1_WorksiteDataCollection :> OperationalActivity {
      doc /* OA1: Worksite data collection/mapping */
      attribute :>> id = "NGHE-OA-001";
      attribute :>> name = "OA1: Worksite Data Collection/Mapping";
      attribute :>> description = "Collect worksite data and build maps (terrain/obstacles/work zones)";
    }
    
    action def OA2_PerformanceRequirementAnalysis :> OperationalActivity {
      doc /* OA2: Performance requirement derivation/verification */
      attribute :>> id = "NGHE-OA-002";
      attribute :>> name = "OA2: Performance Requirement Analysis";
      attribute :>> description = "Derive and verify performance requirements (cycle time, energy, availability)";
    }
    
    action def OA3_WorkPlanningExecution :> OperationalActivity {
      doc /* OA3: Work planning/allocation and autonomy/teleop execution */
      attribute :>> id = "NGHE-OA-003";
      attribute :>> name = "OA3: Work Planning/Allocation and Execution";
      attribute :>> description = "Plan and allocate work, execute using autonomy/teleoperation";
    }
    
    action def OA4_SafetyMonitoringResponse :> OperationalActivity {
      doc /* OA4: Safety monitoring and risk response */
      attribute :>> id = "NGHE-OA-004";
      attribute :>> name = "OA4: Safety Monitoring/Response";
      attribute :>> description = "Monitor safety, trigger deceleration/stop/avoidance";
    }
    
    action def OA5_PerformanceMaintenanceReplanning :> OperationalActivity {
      doc /* OA5: Performance analysis, maintenance planning, replanning */
      attribute :>> id = "NGHE-OA-005";
      attribute :>> name = "OA5: Performance Analysis/Maintenance/Replanning";
      attribute :>> description = "Analyze performance, plan maintenance, and replan work";
    }
    
    part ngheOperationalScenario : OperationalScenario {
      attribute :>> id = "NGHE-OP-SCENARIO";
      attribute :>> name = "NGHE Operational Scenario";
      attribute :>> description = "Operational activities and interactions for NGHE";
      attribute :>> domainType = DomainKind::Operational;
      attribute :>> concernType = ConcernKind::Dynamic;
      attribute :>> stakeholderQuestion = "What do NGHE performers do and how do they interact?";
      
      action oa1 : OA1_WorksiteDataCollection;
      action oa2 : OA2_PerformanceRequirementAnalysis;
      action oa3 : OA3_WorkPlanningExecution;
      action oa4 : OA4_SafetyMonitoringResponse;
      action oa5 : OA5_PerformanceMaintenanceReplanning;
    }
    
    // ---------- Contracts: Business Rules and Information Standards ----------
    
    requirement def BR_VisibilitySafety :> Requirement {
      doc /* If visibility < threshold or human detected → decelerate/stop */
      attribute :>> id = "NGHE-BR-001";
      attribute :>> name = "Visibility/Human Detection Rule";
      attribute :>> description = "If visibility < θ or human detected, decelerate or stop";
    }
    
    requirement def BR_SlopeSpeedLimit :> Requirement {
      doc /* If slope > threshold → speed limit */
      attribute :>> id = "NGHE-BR-002";
      attribute :>> name = "Slope Speed Limit Rule";
      attribute :>> description = "If slope > φ_thr, limit speed";
    }
    
    requirement def BR_CommsSafeTransition :> Requirement {
      doc /* If communication quality < threshold → safe transition */
      attribute :>> id = "NGHE-BR-003";
      attribute :>> name = "Communication Safe Transition Rule";
      attribute :>> description = "If communication quality < q_thr, transition from remote to local safe state";
    }
    
    // Information Items (Message Types)
    part def MSG_Map :> OperationalItem {
      attribute :>> id = "NGHE-MSG-001";
      attribute :>> name = "Map Message";
      attribute :>> description = "Worksite map information";
    }
    
    part def MSG_Tasking :> OperationalItem {
      attribute :>> id = "NGHE-MSG-002";
      attribute :>> name = "Tasking Message";
      attribute :>> description = "Work task assignment";
    }
    
    part def MSG_Route :> OperationalItem {
      attribute :>> id = "NGHE-MSG-003";
      attribute :>> name = "Route Message";
      attribute :>> description = "Route planning information";
    }
    
    part def MSG_Telemetry :> OperationalItem {
      attribute :>> id = "NGHE-MSG-004";
      attribute :>> name = "Telemetry Message";
      attribute :>> description = "Equipment telemetry data";
    }
    
    part def MSG_SafetyAlert :> OperationalItem {
      attribute :>> id = "NGHE-MSG-005";
      attribute :>> name = "Safety Alert Message";
      attribute :>> description = "Safety alerts and emergency stop requests";
    }
    
    part def MSG_Maintenance :> OperationalItem {
      attribute :>> id = "NGHE-MSG-006";
      attribute :>> name = "Maintenance Message";
      attribute :>> description = "Maintenance alerts and plans";
    }
    
    part ngheOperationalContract : OperationalContract {
      attribute :>> id = "NGHE-OP-CONTRACT";
      attribute :>> name = "NGHE Operational Contract";
      attribute :>> description = "Business rules and information standards for NGHE";
      attribute :>> domainType = DomainKind::Operational;
      attribute :>> concernType = ConcernKind::Contracts;
      attribute :>> stakeholderQuestion = "What rules and policies govern NGHE operations?";
      
      part msgMap : MSG_Map;
      part msgTasking : MSG_Tasking;
      part msgRoute : MSG_Route;
      part msgTelemetry : MSG_Telemetry;
      part msgSafetyAlert : MSG_SafetyAlert;
      part msgMaintenance : MSG_Maintenance;
      
      requirement brVisibility : BR_VisibilitySafety;
      requirement brSlope : BR_SlopeSpeedLimit;
      requirement brComms : BR_CommsSafeTransition;
    }
  }

  // ============================================================================
  // P3. SERVICE DOMAIN (HOW-AS-A-SERVICE)
  // ============================================================================
  
  package P3_Service {
    
    // ---------- Static: Service Specifications (Definition/Structure) ----------
    
    part def S1_WorksiteAnalysisService :> Component {
      doc /* Worksite analysis service: worksite model/update, risk area identification */
      attribute :>> id = "NGHE-SVC-S1";
      attribute :>> name = "S1 Worksite Analysis Service";
      attribute :>> description = "Worksite model/update and risk area identification";
      
      part providedPort : Port {
        attribute :>> id = "NGHE-S1-PP";
        attribute :>> name = "WorksiteProvided";
        attribute :>> description = "Provides worksite area model and risk information";
      }
      
      part requiredPort : Port {
        attribute :>> id = "NGHE-S1-RP";
        attribute :>> name = "MapInputRequired";
        attribute :>> description = "Requires input map and sensor data";
      }
    }
    
    part def S2_PerfReqService :> Component {
      doc /* Performance requirement service: derivation/monitoring/calibration */
      attribute :>> id = "NGHE-SVC-S2";
      attribute :>> name = "S2 Performance Requirement Service";
      attribute :>> description = "Performance requirement derivation, monitoring, and calibration";
      
      part providedPort : Port {
        attribute :>> id = "NGHE-S2-PP";
        attribute :>> name = "PerfTargetsProvided";
        attribute :>> description = "Provides performance targets and limits";
      }
      
      part requiredPort : Port {
        attribute :>> id = "NGHE-S2-RP";
        attribute :>> name = "WorksiteModelRequired";
        attribute :>> description = "Requires worksite model and constraints";
      }
    }
    
    part def S3_AutonomyTeleopService :> Component {
      doc /* Autonomy/Teleoperation service */
      attribute :>> id = "NGHE-SVC-S3";
      attribute :>> name = "S3 Autonomy/Teleoperation Service";
      attribute :>> description = "Autonomy assist, path planning, and teleoperation HIL";
      
      part providedPort : Port {
        attribute :>> id = "NGHE-S3-PP";
        attribute :>> name = "AutoTeleopProvided";
        attribute :>> description = "Provides autonomy/teleoperation control";
      }
      
      part requiredPort : Port {
        attribute :>> id = "NGHE-S3-RP";
        attribute :>> name = "PerfTargetsRequired";
        attribute :>> description = "Requires performance targets and work plans";
      }
    }
    
    part def S4_SafetyAssuranceService :> Component {
      doc /* Safety assurance service */
      attribute :>> id = "NGHE-SVC-S4";
      attribute :>> name = "S4 Safety Assurance Service";
      attribute :>> description = "Detection/alert/E-Stop/safety logging";
      
      part providedPort : Port {
        attribute :>> id = "NGHE-S4-PP";
        attribute :>> name = "SafetyProvided";
        attribute :>> description = "Provides safety decisions and logs";
      }
      
      part requiredPort : Port {
        attribute :>> id = "NGHE-S4-RP";
        attribute :>> name = "TelemetryEventsRequired";
        attribute :>> description = "Requires telemetry and event data";
      }
    }
    
    part ngheServiceCatalog : ServiceCatalog {
      attribute :>> id = "NGHE-SVC-CATALOG";
      attribute :>> name = "NGHE Service Catalog";
      attribute :>> description = "Service specifications for NGHE";
      attribute :>> domainType = DomainKind::Service;
      attribute :>> concernType = ConcernKind::Static;
      attribute :>> stakeholderQuestion = "What services exist and what interfaces do they expose for NGHE?";
      
      part s1Worksite : S1_WorksiteAnalysisService;
      part s2PerfReq : S2_PerfReqService;
      part s3AutoTeleop : S3_AutonomyTeleopService;
      part s4Safety : S4_SafetyAssuranceService;
    }
    
    // ---------- Dynamic: Service Orchestration (Interaction/Activity) ----------
    
    action def SO_WorksiteToPerfReq :> Function {
      attribute :>> id = "NGHE-SO-001";
      attribute :>> name = "Worksite to PerfReq";
      attribute :>> description = "S1 provides worksite model to S2";
    }
    
    action def SO_PerfReqToAutoTeleop :> Function {
      attribute :>> id = "NGHE-SO-002";
      attribute :>> name = "PerfReq to Auto/Teleop";
      attribute :>> description = "S2 provides performance targets to S3";
    }
    
    action def SO_AutoTeleopToSafety :> Function {
      attribute :>> id = "NGHE-SO-003";
      attribute :>> name = "Auto/Teleop to Safety";
      attribute :>> description = "S3 provides telemetry/events to S4";
    }
    
    action def SO_SafetyToAutoTeleop :> Function {
      attribute :>> id = "NGHE-SO-004";
      attribute :>> name = "Safety to Auto/Teleop";
      attribute :>> description = "S4 provides safety acknowledgements and E-Stop to S3";
    }
    
    part ngheServiceOrchestration : ServiceOrchestration {
      attribute :>> id = "NGHE-SVC-ORCH";
      attribute :>> name = "NGHE Service Orchestration";
      attribute :>> description = "Service interaction sequences for NGHE";
      attribute :>> domainType = DomainKind::Service;
      attribute :>> concernType = ConcernKind::Dynamic;
      attribute :>> stakeholderQuestion = "How do NGHE services interact and orchestrate?";
      
      action worksiteToPerfReq : SO_WorksiteToPerfReq;
      action perfReqToAutoTeleop : SO_PerfReqToAutoTeleop;
      action autoTeleopToSafety : SO_AutoTeleopToSafety;
      action safetyToAutoTeleop : SO_SafetyToAutoTeleop;
    }
    
    // ---------- Contracts: API Schemas and SLAs ----------
    
    part def NGHE_MSG_Schema :> ServiceContract {
      doc /* NGHE-MSG v1 schema: map/work/route/telemetry/safety */
      attribute :>> id = "NGHE-API-001";
      attribute :>> name = "NGHE-MSG v1 Schema";
      attribute :>> description = "Message schema for NGHE services (map/work/route/telemetry/safety)";
    }
    
    part def SLA_S1_Worksite :> VerificationCriterion {
      attribute :>> id = "NGHE-SLA-S1";
      attribute :>> name = "S1 Worksite SLA";
      attribute :>> description = "Latency p95 ≤ 1.0s, Availability ≥ 99.5%, data lineage and consistency checks";
      attribute latencyP95 : Real = 1.0;
      attribute availability : Real = 99.5;
    }
    
    part def SLA_S2_PerfReq :> VerificationCriterion {
      attribute :>> id = "NGHE-SLA-S2";
      attribute :>> name = "S2 PerfReq SLA";
      attribute :>> description = "Latency p95 ≤ 2.0s, Availability ≥ 99.5%, baseline/calibration history management";
      attribute latencyP95 : Real = 2.0;
      attribute availability : Real = 99.5;
    }
    
    part def SLA_S3_AutoTeleop :> VerificationCriterion {
      attribute :>> id = "NGHE-SLA-S3";
      attribute :>> name = "S3 Autonomy/Teleop SLA";
      attribute :>> description = "Latency p95 ≤ 150ms, Availability ≥ 99.9%, RBAC and control audit logs";
      attribute latencyP95 : Real = 150.0;
      attribute availability : Real = 99.9;
    }
    
    part def SLA_S4_Safety :> VerificationCriterion {
      attribute :>> id = "NGHE-SLA-S4";
      attribute :>> name = "S4 Safety SLA";
      attribute :>> description = "Latency p95 ≤ 100ms, Availability ≥ 99.99%, encryption, redundancy, immutable logs";
      attribute latencyP95 : Real = 100.0;
      attribute availability : Real = 99.99;
    }
    
    part ngheServiceContract : ServiceContractArtifact {
      attribute :>> id = "NGHE-SVC-CONTRACT";
      attribute :>> name = "NGHE Service Contract";
      attribute :>> description = "API schemas and SLAs for NGHE services";
      attribute :>> domainType = DomainKind::Service;
      attribute :>> concernType = ConcernKind::Contracts;
      attribute :>> stakeholderQuestion = "What are the API contracts and SLAs for NGHE services?";
      
      part apiSchema : NGHE_MSG_Schema;
      part slaS1 : SLA_S1_Worksite;
      part slaS2 : SLA_S2_PerfReq;
      part slaS3 : SLA_S3_AutoTeleop;
      part slaS4 : SLA_S4_Safety;
    }
  }

  // ============================================================================
  // P4. RESOURCE DOMAIN (WITH WHAT)
  // ============================================================================
  
  package P4_Resource {
    
    // ---------- Static: System Configuration (Definition/Structure) ----------
    
    part def EquipmentComputing :> Component {
      doc /* Equipment computing resource */
      attribute :>> id = "NGHE-RES-001";
      attribute :>> name = "Equipment Computing";
      attribute :>> description = "On-equipment computing for autonomy and control";
    }
    
    part def EdgeServer :> Component {
      doc /* Edge/site server */
      attribute :>> id = "NGHE-RES-002";
      attribute :>> name = "Edge/Site Server";
      attribute :>> description = "Edge or site server for local processing";
    }
    
    part def CloudAnalytics :> Component {
      doc /* Cloud analytics */
      attribute :>> id = "NGHE-RES-003";
      attribute :>> name = "Cloud Analytics";
      attribute :>> description = "Cloud analytics environment";
    }
    
    part def SensorNetwork :> Component {
      doc /* Sensor network */
      attribute :>> id = "NGHE-RES-004";
      attribute :>> name = "Sensor Network";
      attribute :>> description = "LiDAR, radar, cameras, ultrasonic, IMU, GNSS/RTK";
    }
    
    part def Communications :> Component {
      doc /* Communication systems */
      attribute :>> id = "NGHE-RES-005";
      attribute :>> name = "Communications";
      attribute :>> description = "5G/private radio/Wi-Fi6, V2X, industrial bus";
    }
    
    part ngheSystemConfig : SystemConfiguration {
      attribute :>> id = "NGHE-SYS-CONFIG";
      attribute :>> name = "NGHE System Configuration";
      attribute :>> description = "System resources and physical interfaces for NGHE";
      attribute :>> domainType = DomainKind::Resource;
      attribute :>> concernType = ConcernKind::Static;
      attribute :>> stakeholderQuestion = "What systems exist and how are they connected in NGHE?";
      
      part equipmentComputing : EquipmentComputing;
      part edgeServer : EdgeServer;
      part cloudAnalytics : CloudAnalytics;
      part sensorNet : SensorNetwork;
      part comms : Communications;
    }
    
    // ---------- Dynamic: Resource Behavior (Interaction/StateMachine) ----------
    
    action def Mode_Manual :> State {
      attribute :>> id = "NGHE-MODE-001";
      attribute :>> name = "Manual";
      attribute :>> description = "Manual operation";
    }
    
    action def Mode_Assist :> State {
      attribute :>> id = "NGHE-MODE-002";
      attribute :>> name = "Assist";
      attribute :>> description = "Assisted autonomy";
    }
    
    action def Mode_Autonomous :> State {
      attribute :>> id = "NGHE-MODE-003";
      attribute :>> name = "Autonomous";
      attribute :>> description = "Autonomous mode";
    }
    
    action def Mode_Teleop :> State {
      attribute :>> id = "NGHE-MODE-004";
      attribute :>> name = "Teleoperation";
      attribute :>> description = "Teleoperation mode";
    }
    
    action def Mode_EStop :> State {
      attribute :>> id = "NGHE-MODE-005";
      attribute :>> name = "E-Stop";
      attribute :>> description = "Safety stop mode";
    }
    
    action def Trans_EnableAssist :> Transition {
      attribute :>> id = "NGHE-TR-001";
      attribute :>> name = "Enable Assist";
      attribute :>> description = "Manual → Assist";
    }
    
    action def Trans_EnableAuto :> Transition {
      attribute :>> id = "NGHE-TR-002";
      attribute :>> name = "Enable Auto";
      attribute :>> description = "Assist → Autonomous";
    }
    
    action def Trans_OperatorTakeover :> Transition {
      attribute :>> id = "NGHE-TR-003";
      attribute :>> name = "Operator Takeover";
      attribute :>> description = "Autonomous → Teleoperation";
    }
    
    action def Trans_ResumeAuto :> Transition {
      attribute :>> id = "NGHE-TR-004";
      attribute :>> name = "Resume Auto";
      attribute :>> description = "Teleoperation → Autonomous";
    }
    
    action def Trans_EmergencyStopFromModes :> Transition {
      attribute :>> id = "NGHE-TR-005";
      attribute :>> name = "Emergency Stop";
      attribute :>> description = "Any operating mode → E-Stop";
    }
    
    action def Trans_ResetFromEStop :> Transition {
      attribute :>> id = "NGHE-TR-006";
      attribute :>> name = "Reset from E-Stop";
      attribute :>> description = "E-Stop → Manual";
    }
    
    part ngheResourceBehavior : ResourceBehavior {
      attribute :>> id = "NGHE-RES-BEHAVIOR";
      attribute :>> name = "NGHE Resource Behavior";
      attribute :>> description = "Operational modes and safety transitions for NGHE";
      attribute :>> domainType = DomainKind::Resource;
      attribute :>> concernType = ConcernKind::Dynamic;
      attribute :>> stakeholderQuestion = "How do NGHE resources behave and what states do they exhibit?";
      
      action modeManual : Mode_Manual;
      action modeAssist : Mode_Assist;
      action modeAutonomous : Mode_Autonomous;
      action modeTeleop : Mode_Teleop;
      action modeEStop : Mode_EStop;
      
      action trEnableAssist : Trans_EnableAssist;
      action trEnableAuto : Trans_EnableAuto;
      action trOperatorTakeover : Trans_OperatorTakeover;
      action trResumeAuto : Trans_ResumeAuto;
      action trEmergencyStop : Trans_EmergencyStopFromModes;
      action trResetFromEStop : Trans_ResetFromEStop;
    }
    
    // ---------- Contracts: Technical Standards and Data Models ----------
    
    part def DM_Telemetry :> Item {
      attribute :>> id = "NGHE-DM-001";
      attribute :>> name = "Telemetry Data Model";
      attribute :>> description = "Equipment telemetry data structure";
    }
    
    part def DM_Map :> Item {
      attribute :>> id = "NGHE-DM-002";
      attribute :>> name = "Map Data Model";
      attribute :>> description = "Worksite map data structure";
    }
    
    part def DM_Route :> Item {
      attribute :>> id = "NGHE-DM-003";
      attribute :>> name = "Route Data Model";
      attribute :>> description = "Route data structure";
    }
    
    part def DM_Tasking :> Item {
      attribute :>> id = "NGHE-DM-004";
      attribute :>> name = "Tasking Data Model";
      attribute :>> description = "Tasking data structure";
    }
    
    part def DM_SafetyEvent :> Item {
      attribute :>> id = "NGHE-DM-005";
      attribute :>> name = "Safety Event Data Model";
      attribute :>> description = "Safety event data structure";
    }
    
    part def DM_Maintenance :> Item {
      attribute :>> id = "NGHE-DM-006";
      attribute :>> name = "Maintenance Data Model";
      attribute :>> description = "Maintenance data structure";
    }
    
    part def STD_EquipmentComputing :> Document {
      attribute :>> id = "NGHE-STD-001";
      attribute :>> name = "Equipment Computing Standards";
      attribute :>> description = "≥ 10 TOPS, 5G/private radio, AES-256/GCM, IEC 61508, ISO 13849 (concept)";
    }
    
    part def STD_EdgeServer :> Document {
      attribute :>> id = "NGHE-STD-002";
      attribute :>> name = "Edge/Field Server Standards";
      attribute :>> description = "≥ 5k msg/s, wired/wireless, TLS1.3, ISO 27001";
    }
    
    part def STD_SensorNetwork :> Document {
      attribute :>> id = "NGHE-STD-003";
      attribute :>> name = "Sensor Network Standards";
      attribute :>> description = "≥ 1Gbps, TSN/Ethernet, optional MACsec, industrial safety/EMC";
    }
    
    part def PERF_EquipmentComputing :> VerificationCriterion {
      attribute :>> id = "NGHE-PERF-001";
      attribute :>> name = "Equipment Computing Performance";
      attribute :>> description = "Processing ≥ 10 TOPS, secure communication";
      attribute processingPower : Real = 10.0;
    }
    
    part def PERF_EdgeServer :> VerificationCriterion {
      attribute :>> id = "NGHE-PERF-002";
      attribute :>> name = "Edge/Field Server Performance";
      attribute :>> description = "Throughput ≥ 5k msg/s";
      attribute throughput : Real = 5000.0;
    }
    
    part def PERF_SensorNetwork :> VerificationCriterion {
      attribute :>> id = "NGHE-PERF-003";
      attribute :>> name = "Sensor Network Performance";
      attribute :>> description = "Bandwidth ≥ 1Gbps";
      attribute bandwidth : Real = 1000.0;
    }
    
    part ngheResourceContract : ResourceContract {
      attribute :>> id = "NGHE-RES-CONTRACT";
      attribute :>> name = "NGHE Resource Contract";
      attribute :>> description = "Technical standards and data models for NGHE resources";
      attribute :>> domainType = DomainKind::Resource;
      attribute :>> concernType = ConcernKind::Contracts;
      attribute :>> stakeholderQuestion = "What standards and data models govern NGHE resources?";
      
      part dmTelemetry : DM_Telemetry;
      part dmMap : DM_Map;
      part dmRoute : DM_Route;
      part dmTasking : DM_Tasking;
      part dmSafetyEvent : DM_SafetyEvent;
      part dmMaintenance : DM_Maintenance;
      
      part stdEquip : STD_EquipmentComputing;
      part stdEdge : STD_EdgeServer;
      part stdSensor : STD_SensorNetwork;
      
      part perfEquip : PERF_EquipmentComputing;
      part perfEdge : PERF_EdgeServer;
      part perfSensor : PERF_SensorNetwork;
    }
  }

  // ============================================================================
  // P5. PROJECT DOMAIN (WHEN)
  // ============================================================================
  
  package P5_Project {
    
    // ---------- Static: WBS/Project Structure (Definition) ----------
    
    action def W1_WorksiteAnalysis :> ProjectUnit {
      attribute :>> id = "NGHE-WBS-W1";
      attribute :>> name = "W1 Worksite Analysis";
      attribute :>> description = "Development of worksite analysis capability";
    }
    
    action def W2_PerfReqAnalysis :> ProjectUnit {
      attribute :>> id = "NGHE-WBS-W2";
      attribute :>> name = "W2 Performance Requirements Analysis";
      attribute :>> description = "Development of performance requirement analysis capability";
    }
    
    action def W3_AutonomyTeleopModule :> ProjectUnit {
      attribute :>> id = "NGHE-WBS-W3";
      attribute :>> name = "W3 Autonomy/Teleop Module";
      attribute :>> description = "Development of autonomy/teleoperation module";
    }
    
    action def W4_SafetyAssuranceModule :> ProjectUnit {
      attribute :>> id = "NGHE-WBS-W4";
      attribute :>> name = "W4 Safety Assurance Module";
      attribute :>> description = "Development of safety assurance module";
    }
    
    action def W5_IntegrationTestCertification :> ProjectUnit {
      attribute :>> id = "NGHE-WBS-W5";
      attribute :>> name = "W5 Integration/Test/Certification";
      attribute :>> description = "Integration, verification, and certification";
    }
    
    part ngheProjectStructure : ProjectStructure {
      attribute :>> id = "NGHE-PRJ-STRUCT";
      attribute :>> name = "NGHE Project Structure";
      attribute :>> description = "WBS decomposition for NGHE project";
      attribute :>> domainType = DomainKind::Project;
      attribute :>> concernType = ConcernKind::Static;
      attribute :>> stakeholderQuestion = "How is the NGHE project organized?";
      
      action w1 : W1_WorksiteAnalysis;
      action w2 : W2_PerfReqAnalysis;
      action w3 : W3_AutonomyTeleopModule;
      action w4 : W4_SafetyAssuranceModule;
      action w5 : W5_IntegrationTestCertification;
    }
    
    // ---------- Dynamic: Project Workflow (Activity) ----------
    
    action def PW_W1_Development :> ProjectAction {
      attribute :>> id = "NGHE-PW-001";
      attribute :>> name = "W1 Development";
      attribute :>> description = "Develop worksite analysis module";
    }
    
    action def PW_W2_Development :> ProjectAction {
      attribute :>> id = "NGHE-PW-002";
      attribute :>> name = "W2 Development";
      attribute :>> description = "Develop performance requirements module";
    }
    
    action def PW_W3_Development :> ProjectAction {
      attribute :>> id = "NGHE-PW-003";
      attribute :>> name = "W3 Development";
      attribute :>> description = "Develop autonomy/teleop module";
    }
    
    action def PW_W4_Development :> ProjectAction {
      attribute :>> id = "NGHE-PW-004";
      attribute :>> name = "W4 Development";
      attribute :>> description = "Develop safety assurance module (parallel)";
    }
    
    action def PW_W5_Integration :> ProjectAction {
      attribute :>> id = "NGHE-PW-005";
      attribute :>> name = "W5 Integration";
      attribute :>> description = "System integration, verification, and certification";
    }
    
    part ngheProjectWorkflow : ProjectWorkflow {
      attribute :>> id = "NGHE-PRJ-WORKFLOW";
      attribute :>> name = "NGHE Project Workflow";
      attribute :>> description = "Project activity flow: W1→W2→W3, W4 parallel, W5 integration/certification";
      attribute :>> domainType = DomainKind::Project;
      attribute :>> concernType = ConcernKind::Dynamic;
      attribute :>> stakeholderQuestion = "What is the NGHE project schedule and critical path?";
      
      action pwW1 : PW_W1_Development;
      action pwW2 : PW_W2_Development;
      action pwW3 : PW_W3_Development;
      action pwW4 : PW_W4_Development;
      action pwW5 : PW_W5_Integration;
    }
    
    // ---------- Contracts: Milestones and DoD ----------
    
    part def M1_Milestone :> VerificationMilestone {
      attribute :>> id = "NGHE-MS-M1";
      attribute :>> name = "M1 Milestone";
      attribute :>> description = "R1: C1 basic, S1 draft, resource baseline";
      attribute release : String = "R1";
    }
    
    part def M2_Milestone :> VerificationMilestone {
      attribute :>> id = "NGHE-MS-M2";
      attribute :>> name = "M2 Milestone";
      attribute :>> description = "R2: C2 refined, S2/3 pilot, safety logic v1";
      attribute release : String = "R2";
    }
    
    part def M3_Milestone :> VerificationMilestone {
      attribute :>> id = "NGHE-MS-M3";
      attribute :>> name = "M3 Milestone";
      attribute :>> description = "R3: C3/4 operational, SLA/safety advanced, certification package";
      attribute release : String = "R3";
    }
    
    part def DoD_M1 :> VerificationCriterion {
      attribute :>> id = "NGHE-DOD-M1";
      attribute :>> name = "M1 Definition of Done";
      attribute :>> description = "C1 basic capability verified, S1 interface draft approved, resource baseline established";
    }
    
    part def DoD_M2 :> VerificationCriterion {
      attribute :>> id = "NGHE-DOD-M2";
      attribute :>> name = "M2 Definition of Done";
      attribute :>> description = "C2 refined, S2/S3 pilot tested, safety logic v1 demonstrated";
    }
    
    part def DoD_M3 :> VerificationCriterion {
      attribute :>> id = "NGHE-DOD-M3";
      attribute :>> name = "M3 Definition of Done";
      attribute :>> description = "C3/C4 operational, SLA and safety goals verified, certification package ready";
    }
    
    part ngheProjectContract : ProjectContract {
      attribute :>> id = "NGHE-PRJ-CONTRACT";
      attribute :>> name = "NGHE Project Contract";
      attribute :>> description = "Milestones and acceptance criteria for NGHE project";
      attribute :>> domainType = DomainKind::Project;
      attribute :>> concernType = ConcernKind::Contracts;
      attribute :>> stakeholderQuestion = "What are the acceptance criteria for each NGHE milestone?";
      
      part m1 : M1_Milestone;
      part m2 : M2_Milestone;
      part m3 : M3_Milestone;
      
      part dodM1 : DoD_M1;
      part dodM2 : DoD_M2;
      part dodM3 : DoD_M3;
    }
  }

  // ============================================================================
  // P6. RELATIONSHIPS & TRACEABILITY (CONNECTION-BASED)
  // ============================================================================
  
  package P6_Relationships {
    
    // ========================================================================
    // Performer → OperationalActivity (Performs)
    // ========================================================================
    
    connection equipmentPerformsOA1 : Performs {
      end structure ::> P2_Operational::nghePerformerStructure.equipment;
      end behavior ::> P2_Operational::ngheOperationalScenario.oa1;
    }
    
    connection equipmentPerformsOA3 : Performs {
      end structure ::> P2_Operational::nghePerformerStructure.equipment;
      end behavior ::> P2_Operational::ngheOperationalScenario.oa3;
    }
    
    connection equipmentPerformsOA5 : Performs {
      end structure ::> P2_Operational::nghePerformerStructure.equipment;
      end behavior ::> P2_Operational::ngheOperationalScenario.oa5;
    }
    
    connection remoteOperatorPerformsOA3 : Performs {
      end structure ::> P2_Operational::nghePerformerStructure.remoteOperator;
      end behavior ::> P2_Operational::ngheOperationalScenario.oa3;
    }
    
    connection remoteOperatorPerformsOA4 : Performs {
      end structure ::> P2_Operational::nghePerformerStructure.remoteOperator;
      end behavior ::> P2_Operational::ngheOperationalScenario.oa4;
    }
    
    connection siteManagerPerformsOA4 : Performs {
      end structure ::> P2_Operational::nghePerformerStructure.siteManager;
      end behavior ::> P2_Operational::ngheOperationalScenario.oa4;
    }
    
    connection siteManagerPerformsOA5 : Performs {
      end structure ::> P2_Operational::nghePerformerStructure.siteManager;
      end behavior ::> P2_Operational::ngheOperationalScenario.oa5;
    }
    
    connection fleetSystemPerformsOA2 : Performs {
      end structure ::> P2_Operational::nghePerformerStructure.fleetSystem;
      end behavior ::> P2_Operational::ngheOperationalScenario.oa2;
    }
    
    connection fleetSystemPerformsOA3 : Performs {
      end structure ::> P2_Operational::nghePerformerStructure.fleetSystem;
      end behavior ::> P2_Operational::ngheOperationalScenario.oa3;
    }
    
    connection sensorNetworkPerformsOA1 : Performs {
      end structure ::> P2_Operational::nghePerformerStructure.sensorNetwork;
      end behavior ::> P2_Operational::ngheOperationalScenario.oa1;
    }
    
    connection sensorNetworkPerformsOA4 : Performs {
      end structure ::> P2_Operational::nghePerformerStructure.sensorNetwork;
      end behavior ::> P2_Operational::ngheOperationalScenario.oa4;
    }
    
    // ========================================================================
    // Capability → OperationalActivity (BasedOn)
    // ========================================================================
    
    connection c1BasedOnOA1 : BasedOn {
      end source ::> P1_Strategy::ngheCapabilityTree.c1;
      end target ::> P2_Operational::ngheOperationalScenario.oa1;
    }
    
    connection c2BasedOnOA2 : BasedOn {
      end source ::> P1_Strategy::ngheCapabilityTree.c2;
      end target ::> P2_Operational::ngheOperationalScenario.oa2;
    }
    
    connection c3BasedOnOA3 : BasedOn {
      end source ::> P1_Strategy::ngheCapabilityTree.c3;
      end target ::> P2_Operational::ngheOperationalScenario.oa3;
    }
    
    connection c4BasedOnOA4 : BasedOn {
      end source ::> P1_Strategy::ngheCapabilityTree.c4;
      end target ::> P2_Operational::ngheOperationalScenario.oa4;
    }
    
    // ========================================================================
    // Mission Tasks → OperationalActivity (AchievedBy)
    // ========================================================================
    
    connection worksiteAnalysisAchievedByOA1 : AchievedBy {
      end source ::> P1_Strategy::ngheMissionFlow.worksiteAnalysis;
      end target ::> P2_Operational::ngheOperationalScenario.oa1;
    }
    
    connection perfDerivationAchievedByOA2 : AchievedBy {
      end source ::> P1_Strategy::ngheMissionFlow.perfDerivation;
      end target ::> P2_Operational::ngheOperationalScenario.oa2;
    }
    
    connection planningAchievedByOA3 : AchievedBy {
      end source ::> P1_Strategy::ngheMissionFlow.planningAllocation;
      end target ::> P2_Operational::ngheOperationalScenario.oa3;
    }
    
    connection autoTeleopAchievedByOA3 : AchievedBy {
      end source ::> P1_Strategy::ngheMissionFlow.autoTeleop;
      end target ::> P2_Operational::ngheOperationalScenario.oa3;
    }
    
    connection safetyEvalAchievedByOA4 : AchievedBy {
      end source ::> P1_Strategy::ngheMissionFlow.safetyEval;
      end target ::> P2_Operational::ngheOperationalScenario.oa4;
    }
    
    // ========================================================================
    // Performer → Component (ImplementedBy)
    // ========================================================================
    
    connection equipmentImplementedByComputing : ImplementedBy {
      end source ::> P2_Operational::nghePerformerStructure.equipment;
      end target ::> P4_Resource::ngheSystemConfig.equipmentComputing;
    }
    
    connection remoteOperatorImplementedByComms : ImplementedBy {
      end source ::> P2_Operational::nghePerformerStructure.remoteOperator;
      end target ::> P4_Resource::ngheSystemConfig.comms;
    }
    
    connection siteManagerImplementedByEdge : ImplementedBy {
      end source ::> P2_Operational::nghePerformerStructure.siteManager;
      end target ::> P4_Resource::ngheSystemConfig.edgeServer;
    }
    
    connection fleetSystemImplementedByEdge : ImplementedBy {
      end source ::> P2_Operational::nghePerformerStructure.fleetSystem;
      end target ::> P4_Resource::ngheSystemConfig.edgeServer;
    }
    
    connection sensorNetworkImplementedBySensorResource : ImplementedBy {
      end source ::> P2_Operational::nghePerformerStructure.sensorNetwork;
      end target ::> P4_Resource::ngheSystemConfig.sensorNet;
    }
    
    // ========================================================================
    // OperationalActivity → Service (ImplementedBy)
    // ========================================================================
    
    connection oa1ImplementedByS1 : ImplementedBy {
      end source ::> P2_Operational::ngheOperationalScenario.oa1;
      end target ::> P3_Service::ngheServiceCatalog.s1Worksite;
    }
    
    connection oa2ImplementedByS2 : ImplementedBy {
      end source ::> P2_Operational::ngheOperationalScenario.oa2;
      end target ::> P3_Service::ngheServiceCatalog.s2PerfReq;
    }
    
    connection oa3ImplementedByS3 : ImplementedBy {
      end source ::> P2_Operational::ngheOperationalScenario.oa3;
      end target ::> P3_Service::ngheServiceCatalog.s3AutoTeleop;
    }
    
    connection oa4ImplementedByS4 : ImplementedBy {
      end source ::> P2_Operational::ngheOperationalScenario.oa4;
      end target ::> P3_Service::ngheServiceCatalog.s4Safety;
    }
    
    connection oa5ImplementedByS2 : ImplementedBy {
      end source ::> P2_Operational::ngheOperationalScenario.oa5;
      end target ::> P3_Service::ngheServiceCatalog.s2PerfReq;
    }
    
    // ========================================================================
    // CommunicationPath → Performer (ConnectsTo)
    // ========================================================================
    
    connection nlTelemetryConnectsEquipment : ConnectsTo {
      end source ::> P2_Operational::nghePerformerStructure.nlTelemetry;
      end target ::> P2_Operational::nghePerformerStructure.equipment;
    }
    
    connection nlTelemetryConnectsFleet : ConnectsTo {
      end source ::> P2_Operational::nghePerformerStructure.nlTelemetry;
      end target ::> P2_Operational::nghePerformerStructure.fleetSystem;
    }
    
    connection nlTelemetryConnectsEdge : ConnectsTo {
      end source ::> P2_Operational::nghePerformerStructure.nlTelemetry;
      end target ::> P2_Operational::nghePerformerStructure.edgeGateway;
    }
    
    connection nlTaskingConnectsFleet : ConnectsTo {
      end source ::> P2_Operational::nghePerformerStructure.nlTasking;
      end target ::> P2_Operational::nghePerformerStructure.fleetSystem;
    }
    
    connection nlTaskingConnectsEquipment : ConnectsTo {
      end source ::> P2_Operational::nghePerformerStructure.nlTasking;
      end target ::> P2_Operational::nghePerformerStructure.equipment;
    }
    
    connection nlTaskingConnectsRemoteOperator : ConnectsTo {
      end source ::> P2_Operational::nghePerformerStructure.nlTasking;
      end target ::> P2_Operational::nghePerformerStructure.remoteOperator;
    }
    
    connection nlRoutePlanConnectsFleet : ConnectsTo {
      end source ::> P2_Operational::nghePerformerStructure.nlRoutePlan;
      end target ::> P2_Operational::nghePerformerStructure.fleetSystem;
    }
    
    connection nlRoutePlanConnectsEquipment : ConnectsTo {
      end source ::> P2_Operational::nghePerformerStructure.nlRoutePlan;
      end target ::> P2_Operational::nghePerformerStructure.equipment;
    }
    
    connection nlSafetyStopConnectsEquipment : ConnectsTo {
      end source ::> P2_Operational::nghePerformerStructure.nlSafetyStop;
      end target ::> P2_Operational::nghePerformerStructure.equipment;
    }
    
    connection nlSafetyStopConnectsSiteManager : ConnectsTo {
      end source ::> P2_Operational::nghePerformerStructure.nlSafetyStop;
      end target ::> P2_Operational::nghePerformerStructure.siteManager;
    }
    
    connection nlSafetyStopConnectsRemoteOperator : ConnectsTo {
      end source ::> P2_Operational::nghePerformerStructure.nlSafetyStop;
      end target ::> P2_Operational::nghePerformerStructure.remoteOperator;
    }
    
    connection nlMaintenanceConnectsEquipment : ConnectsTo {
      end source ::> P2_Operational::nghePerformerStructure.nlMaintenance;
      end target ::> P2_Operational::nghePerformerStructure.equipment;
    }
    
    connection nlMaintenanceConnectsFleet : ConnectsTo {
      end source ::> P2_Operational::nghePerformerStructure.nlMaintenance;
      end target ::> P2_Operational::nghePerformerStructure.fleetSystem;
    }
    
    // ========================================================================
    // CommunicationPath → OperationalItem (Transfers)
    // ========================================================================
    
    connection nlTelemetryTransfersTelemetry : Transfers {
      end source ::> P2_Operational::nghePerformerStructure.nlTelemetry;
      end target ::> P2_Operational::ngheOperationalContract.msgTelemetry;
    }
    
    connection nlTaskingTransfersTasking : Transfers {
      end source ::> P2_Operational::nghePerformerStructure.nlTasking;
      end target ::> P2_Operational::ngheOperationalContract.msgTasking;
    }
    
    connection nlRoutePlanTransfersRoute : Transfers {
      end source ::> P2_Operational::nghePerformerStructure.nlRoutePlan;
      end target ::> P2_Operational::ngheOperationalContract.msgRoute;
    }
    
    connection nlSafetyStopTransfersSafetyAlert : Transfers {
      end source ::> P2_Operational::nghePerformerStructure.nlSafetyStop;
      end target ::> P2_Operational::ngheOperationalContract.msgSafetyAlert;
    }
    
    connection nlMaintenanceTransfersMaintenance : Transfers {
      end source ::> P2_Operational::nghePerformerStructure.nlMaintenance;
      end target ::> P2_Operational::ngheOperationalContract.msgMaintenance;
    }
    
    // ========================================================================
    // Service → Resource (ImplementedBy)
    // ========================================================================
    
    connection s1ImplementedBySensorNet : ImplementedBy {
      end source ::> P3_Service::ngheServiceCatalog.s1Worksite;
      end target ::> P4_Resource::ngheSystemConfig.sensorNet;
    }
    
    connection s1ImplementedByEdge : ImplementedBy {
      end source ::> P3_Service::ngheServiceCatalog.s1Worksite;
      end target ::> P4_Resource::ngheSystemConfig.edgeServer;
    }
    
    connection s2ImplementedByEdge : ImplementedBy {
      end source ::> P3_Service::ngheServiceCatalog.s2PerfReq;
      end target ::> P4_Resource::ngheSystemConfig.edgeServer;
    }
    
    connection s2ImplementedByCloud : ImplementedBy {
      end source ::> P3_Service::ngheServiceCatalog.s2PerfReq;
      end target ::> P4_Resource::ngheSystemConfig.cloudAnalytics;
    }
    
    connection s3ImplementedByEquipmentComputing : ImplementedBy {
      end source ::> P3_Service::ngheServiceCatalog.s3AutoTeleop;
      end target ::> P4_Resource::ngheSystemConfig.equipmentComputing;
    }
    
    connection s3ImplementedByComms : ImplementedBy {
      end source ::> P3_Service::ngheServiceCatalog.s3AutoTeleop;
      end target ::> P4_Resource::ngheSystemConfig.comms;
    }
    
    connection s4ImplementedBySensorNet : ImplementedBy {
      end source ::> P3_Service::ngheServiceCatalog.s4Safety;
      end target ::> P4_Resource::ngheSystemConfig.sensorNet;
    }
    
    connection s4ImplementedByComms : ImplementedBy {
      end source ::> P3_Service::ngheServiceCatalog.s4Safety;
      end target ::> P4_Resource::ngheSystemConfig.comms;
    }
    
    // ========================================================================
    // Capability → Service (ImplementedBy)
    // ========================================================================
    
    connection c1ImplementedByS1 : ImplementedBy {
      end source ::> P1_Strategy::ngheCapabilityTree.c1;
      end target ::> P3_Service::ngheServiceCatalog.s1Worksite;
    }
    
    connection c2ImplementedByS2 : ImplementedBy {
      end source ::> P1_Strategy::ngheCapabilityTree.c2;
      end target ::> P3_Service::ngheServiceCatalog.s2PerfReq;
    }
    
    connection c3ImplementedByS3 : ImplementedBy {
      end source ::> P1_Strategy::ngheCapabilityTree.c3;
      end target ::> P3_Service::ngheServiceCatalog.s3AutoTeleop;
    }
    
    connection c4ImplementedByS4 : ImplementedBy {
      end source ::> P1_Strategy::ngheCapabilityTree.c4;
      end target ::> P3_Service::ngheServiceCatalog.s4Safety;
    }
    
    // ========================================================================
    // Mission → Capability (AchievedBy)
    // ========================================================================
    
    connection missionAchievedByC1 : AchievedBy {
      end source ::> P1_Strategy::ngheMissionFlow.missionThread;
      end target ::> P1_Strategy::ngheCapabilityTree.c1;
    }
    
    connection missionAchievedByC2 : AchievedBy {
      end source ::> P1_Strategy::ngheMissionFlow.missionThread;
      end target ::> P1_Strategy::ngheCapabilityTree.c2;
    }
    
    connection missionAchievedByC3 : AchievedBy {
      end source ::> P1_Strategy::ngheMissionFlow.missionThread;
      end target ::> P1_Strategy::ngheCapabilityTree.c3;
    }
    
    connection missionAchievedByC4 : AchievedBy {
      end source ::> P1_Strategy::ngheMissionFlow.missionThread;
      end target ::> P1_Strategy::ngheCapabilityTree.c4;
    }
    
    // ========================================================================
    // ProjectUnit → Capability (Supplies)
    // ========================================================================
    
    connection w1SuppliesC1 : Supplies {
      end source ::> P5_Project::ngheProjectStructure.w1;
      end target ::> P1_Strategy::ngheCapabilityTree.c1;
    }
    
    connection w2SuppliesC2 : Supplies {
      end source ::> P5_Project::ngheProjectStructure.w2;
      end target ::> P1_Strategy::ngheCapabilityTree.c2;
    }
    
    connection w3SuppliesC3 : Supplies {
      end source ::> P5_Project::ngheProjectStructure.w3;
      end target ::> P1_Strategy::ngheCapabilityTree.c3;
    }
    
    connection w4SuppliesC4 : Supplies {
      end source ::> P5_Project::ngheProjectStructure.w4;
      end target ::> P1_Strategy::ngheCapabilityTree.c4;
    }
  }

  // ============================================================================
  // P6. BASIC TRACEABILITY (CAPABILITY ↔ SERVICE ↔ RESOURCE ↔ MILESTONE)
  // ============================================================================
  
  package P6_Traceability {
    
    part def CapabilityServiceTrace {
      attribute capability : String;
      attribute services : String[1..*];
    }
    
    part traceC1S1 : CapabilityServiceTrace {
      attribute :>> capability = "C1 Worksite Area Analysis";
      attribute :>> services = ("S1 WorksiteAnalysis");
    }
    
    part traceC2S2 : CapabilityServiceTrace {
      attribute :>> capability = "C2 Equipment Performance Requirements Analysis";
      attribute :>> services = ("S2 PerfReq");
    }
    
    part traceC3S3 : CapabilityServiceTrace {
      attribute :>> capability = "C3 Autonomy/Teleoperation Analysis";
      attribute :>> services = ("S3 AutonomyTeleop");
    }
    
    part traceC4S4 : CapabilityServiceTrace {
      attribute :>> capability = "C4 Safety Analysis";
      attribute :>> services = ("S4 SafetyAssurance");
    }
    
    part def ServiceResourceTrace {
      attribute service : String;
      attribute resources : String[1..*];
    }
    
    part traceS1Res : ServiceResourceTrace {
      attribute :>> service = "S1 WorksiteAnalysis";
      attribute :>> resources = ("Sensor Network", "Edge/Site Server");
    }
    
    part traceS2Res : ServiceResourceTrace {
      attribute :>> service = "S2 PerfReq";
      attribute :>> resources = ("Fleet Management", "Edge/Site Server", "Cloud Analytics");
    }
    
    part traceS3Res : ServiceResourceTrace {
      attribute :>> service = "S3 AutonomyTeleop";
      attribute :>> resources = ("Equipment Computing", "5G/Private Radio", "Remote HMI");
    }
    
    part traceS4Res : ServiceResourceTrace {
      attribute :>> service = "S4 SafetyAssurance";
      attribute :>> resources = ("Safety HW (E-Stop, HSM)", "Logging Storage");
    }
    
    part def MilestoneDeliveryTrace {
      attribute item : String;
      attribute m1Status : String;
      attribute m2Status : String;
      attribute m3Status : String;
    }
    
    part traceC1S1_MS : MilestoneDeliveryTrace {
      attribute :>> item = "C1/S1";
      attribute :>> m1Status = "Delivered";
      attribute :>> m2Status = "Updated";
      attribute :>> m3Status = "Updated";
    }
    
    part traceC2S2_MS : MilestoneDeliveryTrace {
      attribute :>> item = "C2/S2";
      attribute :>> m1Status = "-";
      attribute :>> m2Status = "Delivered";
      attribute :>> m3Status = "Updated";
    }
    
    part traceC3S3_MS : MilestoneDeliveryTrace {
      attribute :>> item = "C3/S3";
      attribute :>> m1Status = "-";
      attribute :>> m2Status = "Pilot";
      attribute :>> m3Status = "Delivered";
    }
    
    part traceC4S4_MS : MilestoneDeliveryTrace {
      attribute :>> item = "C4/S4";
      attribute :>> m1Status = "-";
      attribute :>> m2Status = "v1";
      attribute :>> m3Status = "Delivered";
    }
  }

  // ============================================================================
  // NGHE S2AF GRID INSTANCE
  // ============================================================================
  
  part ngheArchitecture : S2AFGrid {
    attribute id = "NGHE-ARCH-001";
    attribute name = "NGHE Architecture";
    attribute description = "Next Generation Heavy Equipment Architecture based on S2AF";
    attribute version = "1.0";
    
    // Strategy Domain
    part strategyStatic = P1_Strategy::ngheCapabilityTree;
    part strategyDynamic = P1_Strategy::ngheMissionFlow;
    part strategyContracts = P1_Strategy::ngheCapabilityContract;
    
    // Operational Domain
    part operationalStatic = P2_Operational::nghePerformerStructure;
    part operationalDynamic = P2_Operational::ngheOperationalScenario;
    part operationalContracts = P2_Operational::ngheOperationalContract;
    
    // Service Domain
    part serviceStatic = P3_Service::ngheServiceCatalog;
    part serviceDynamic = P3_Service::ngheServiceOrchestration;
    part serviceContracts = P3_Service::ngheServiceContract;
    
    // Resource Domain
    part resourceStatic = P4_Resource::ngheSystemConfig;
    part resourceDynamic = P4_Resource::ngheResourceBehavior;
    part resourceContracts = P4_Resource::ngheResourceContract;
    
    // Project Domain
    part projectStatic = P5_Project::ngheProjectStructure;
    part projectDynamic = P5_Project::ngheProjectWorkflow;
    part projectContracts = P5_Project::ngheProjectContract;
  }
}
