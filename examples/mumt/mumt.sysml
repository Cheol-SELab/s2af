/**
 * MUMT (Manned-Unmanned Teaming) Architecture Model
 * Based on S2AF (SysML v2 Aligned Architecture Framework)
 *
 * This model defines the MUMT system architecture following the S2AF grid structure:
 * - Strategy Domain (Why): Capabilities, Mission Threads, KPIs
 * - Operational Domain (What): Performers, Activities, Information Exchange
 * - Service Domain (How): Service Specifications, Orchestration, SLAs
 * - Resource Domain (With What): Systems, Configurations, Standards
 * - Project Domain (When): WBS, Workflows, Milestones
 */

package MUMT {
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
    doc /* Stakeholders: Mission Commander, Flight Squadron, UxV Operators,
           Comm/Security Officers, System Engineers, PM

           Key Questions:
           - Which capabilities and services/resources are essential for MUMT mission success?
           - What is the quantitative effect of autonomous collaboration on mission time and success rate?
           - Where and how are survivability/security requirements (detection avoidance, link protection) satisfied/verified?
           - At which project milestones are which capabilities delivered? */

    part def MUMTStakeholder :> Organization {
      attribute role : String;
    }

    part missionCommander : MUMTStakeholder {
      attribute :>> id = "STK-001";
      attribute :>> name = "Mission Commander";
      attribute :>> description = "Responsible for overall mission success";
      attribute :>> role = "Command";
    }

    part flightSquadron : MUMTStakeholder {
      attribute :>> id = "STK-002";
      attribute :>> name = "Flight Squadron";
      attribute :>> description = "Manned aircraft operations";
      attribute :>> role = "Operations";
    }

    part uxvOperator : MUMTStakeholder {
      attribute :>> id = "STK-003";
      attribute :>> name = "UxV Operator";
      attribute :>> description = "Unmanned vehicle operations";
      attribute :>> role = "Operations";
    }

    part commSecurityOfficer : MUMTStakeholder {
      attribute :>> id = "STK-004";
      attribute :>> name = "Comm/Security Officer";
      attribute :>> description = "Communications and security management";
      attribute :>> role = "Security";
    }

    part systemEngineer : MUMTStakeholder {
      attribute :>> id = "STK-005";
      attribute :>> name = "System Engineer";
      attribute :>> description = "System design and integration";
      attribute :>> role = "Engineering";
    }

    part projectManager : MUMTStakeholder {
      attribute :>> id = "STK-006";
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

    action def MUMTCoreCapability :> Capability {
      doc /* Root capability for MUMT system */
    }

    action def C1_IntegratedOperationalAreaAnalysis :> Capability {
      doc /* Integrated Operational Area Analysis capability
             Provides multi-sensor fusion and threat assessment */
      attribute :>> id = "CAP-C1";
      attribute :>> name = "Integrated Operational Area Analysis";
      attribute :>> description = "Multi-sensor data collection, normalization, and integrated threat assessment";
    }

    action def C2_MissionControlConceptAnalysis :> Capability {
      doc /* Mission Control Concept Analysis capability
             Provides mission planning, allocation, and human-machine collaboration */
      attribute :>> id = "CAP-C2";
      attribute :>> name = "Mission Control Concept Analysis";
      attribute :>> description = "Mission planning, task allocation, and human-in-the-loop control";
    }

    action def C3_AutonomousCollaborationAnalysis :> Capability {
      doc /* Autonomous Collaboration Analysis capability
             Provides distributed cooperation, consensus, and conflict resolution */
      attribute :>> id = "CAP-C3";
      attribute :>> name = "Autonomous Collaboration Analysis";
      attribute :>> description = "Distributed cooperative planning, consensus, and replanning";
    }

    action def C4_SurvivabilitySecurityAnalysis :> Capability {
      doc /* Survivability/Security Analysis capability
             Provides security monitoring, encryption, and anomaly detection */
      attribute :>> id = "CAP-C4";
      attribute :>> name = "Survivability/Security Analysis";
      attribute :>> description = "Security monitoring, encryption, key rotation, and intrusion detection";
    }

    // Capability hierarchy usage
    part mumtCapabilityTree : CapabilityTaxonomy {
      attribute :>> id = "MUMT-CAP-TREE";
      attribute :>> name = "MUMT Capability Tree";
      attribute :>> description = "Hierarchical decomposition of MUMT capabilities";
      attribute :>> domainType = DomainKind::Strategy;
      attribute :>> concernType = ConcernKind::Static;
      attribute :>> stakeholderQuestion = "What capabilities exist and how are they organized for MUMT?";

      action c1 : C1_IntegratedOperationalAreaAnalysis;
      action c2 : C2_MissionControlConceptAnalysis;
      action c3 : C3_AutonomousCollaborationAnalysis;
      action c4 : C4_SurvivabilitySecurityAnalysis;
    }

    // ---------- Dynamic: Mission Thread (Activity/Interaction) ----------

    action def MUMTMissionThread :> Mission {
      doc /* Main mission thread: Detect → Fuse → Allocate/Control → Collaborate → Evaluate/Replan */
      attribute :>> id = "MSN-001";
      attribute :>> name = "MUMT Mission Thread";
      attribute :>> description = "End-to-end mission flow from detection to evaluation";
    }

    item def MissionData;

    action def MT_Detect :> OperationalTask {
      in input : MissionData;
      out output : MissionData;
      attribute :>> id = "MT-001";
      attribute :>> name = "Detect (Sensor)";
      attribute :>> description = "Multi-sensor target detection and data collection";
    }

    action def MT_Fuse :> OperationalTask {
      in input : MissionData;
      out output : MissionData;
      attribute :>> id = "MT-002";
      attribute :>> name = "Integrated Assessment (Fusion)";
      attribute :>> description = "Multi-source data fusion and threat assessment";
    }

    action def MT_Allocate :> OperationalTask {
      in input : MissionData;
      out output : MissionData;
      attribute :>> id = "MT-003";
      attribute :>> name = "Mission Allocation/Control";
      attribute :>> description = "Task allocation and human-machine collaborative control";
    }

    action def MT_Collaborate :> OperationalTask {
      in input : MissionData;
      out output : MissionData;
      attribute :>> id = "MT-004";
      attribute :>> name = "Collaborative Execution";
      attribute :>> description = "Autonomous cooperative execution among platforms";
    }

    action def MT_Evaluate :> OperationalTask {
      in input : MissionData;
      out output : MissionData;
      attribute :>> id = "MT-005";
      attribute :>> name = "Evaluate/Replan";
      attribute :>> description = "Mission outcome evaluation and adaptive replanning";
    }

    part mumtMissionFlow : CapabilityRealizationFlow {
      attribute :>> id = "MUMT-MSN-FLOW";
      attribute :>> name = "MUMT Mission Realization Flow";
      attribute :>> description = "Mission thread from detection to evaluation";
      attribute :>> domainType = DomainKind::Strategy;
      attribute :>> concernType = ConcernKind::Dynamic;
      attribute :>> stakeholderQuestion = "How are MUMT capabilities realized through mission threads?";

      action missionThread : MUMTMissionThread;
      action detect : MT_Detect;
      action fuse : MT_Fuse;
      action allocates : MT_Allocate;
      action collaborate : MT_Collaborate;
      action evaluate : MT_Evaluate;

      // Flow: detect → fuse → allocates → collaborate → evaluate
      flow from detect.output to fuse.input;
      flow from fuse.output to allocates.input;
      flow from allocates.output to collaborate.input;
      flow from collaborate.output to evaluate.input;
    }

    // ---------- Contracts: KPIs and Constraints (Data Definition/Parametric) ----------

    // KPI Value Types
    attribute def LatencyKPI {
      attribute value : Real;
      attribute unit : String = "seconds";
      attribute threshold : Real;
    }

    attribute def SuccessRateKPI {
      attribute value : Real;
      attribute unit : String = "percent";
      attribute threshold : Real;
    }

    attribute def AvailabilityKPI {
      attribute value : Real;
      attribute unit : String = "ratio";
      attribute threshold : Real;
    }

    attribute def SecurityRiskKPI {
      attribute value : Real;
      attribute unit : String = "index";
      attribute threshold : Real;
    }

    // KPI Definitions
    part def KPI_TTV :> VerificationCriterion {
      doc /* Target-to-Vector mission allocation latency */
      attribute :>> id = "KPI-001";
      attribute :>> name = "TTV Latency";
      attribute :>> description = "Target-to-Vector mission allocation delay ≤ 5s";
      attribute threshold : Real = 5.0;
    }

    part def KPI_CollaborationSuccessRate :> VerificationCriterion {
      doc /* Collaboration success rate under degraded comms */
      attribute :>> id = "KPI-002";
      attribute :>> name = "Collaboration Success Rate";
      attribute :>> description = "Collaboration success rate ≥ 95% (10% packet loss assumption)";
      attribute threshold : Real = 95.0;
    }

    part def KPI_LinkAvailability :> VerificationCriterion {
      doc /* Link availability under EW environment */
      attribute :>> id = "KPI-003";
      attribute :>> name = "Link Availability (SV)";
      attribute :>> description = "Link availability ≥ 0.98 under EW conditions";
      attribute threshold : Real = 0.98;
    }

    part def KPI_SecurityRisk :> VerificationCriterion {
      doc /* Security risk index */
      attribute :>> id = "KPI-004";
      attribute :>> name = "Security Risk Index";
      attribute :>> description = "SecRisk ≤ 0.2 (vulnerability × exposure × impact)";
      attribute threshold : Real = 0.2;
    }

    // Parametric Constraints
    constraint def LatencyConstraint {
      doc /* Total latency constraint: latency_sense + latency_fuse + latency_control + latency_link ≤ 5s */
      attribute latency_sense : Real;
      attribute latency_fuse : Real;
      attribute latency_control : Real;
      attribute latency_link : Real;
      attribute latency_total : Real = latency_sense + latency_fuse + latency_control + latency_link;
      constraint { latency_total <= 5.0 }
    }

    constraint def LinkAvailabilityConstraint {
      doc /* Link availability constraint */
      attribute availability_link : Real;
      constraint { availability_link >= 0.98 }
    }

    constraint def ThroughputConstraint {
      doc /* Control throughput constraint */
      attribute throughput_ctrl : Real;
      constraint { throughput_ctrl >= 200.0 } // kbps
    }

    constraint def CryptoStrengthConstraint {
      doc /* Encryption strength constraint */
      attribute crypto_bits : Integer;
      constraint { crypto_bits >= 256 } // AES-256
    }

    part mumtCapabilityContract : CapabilityContract {
      attribute :>> id = "MUMT-CAP-CONTRACT";
      attribute :>> name = "MUMT Capability Contract";
      attribute :>> description = "KPIs and constraints for MUMT capabilities";
      attribute :>> domainType = DomainKind::Strategy;
      attribute :>> concernType = ConcernKind::Contracts;
      attribute :>> stakeholderQuestion = "How are MUMT capabilities measured and validated?";

      part kpiTTV : KPI_TTV;
      part kpiCollabSuccess : KPI_CollaborationSuccessRate;
      part kpiLinkAvail : KPI_LinkAvailability;
      part kpiSecRisk : KPI_SecurityRisk;
    }

    part def CapabilityRoadmapEntry {
      attribute capability : String;
      attribute r1Status : String;
      attribute r2Status : String;
      attribute r3Status : String;
    }

    part c1Roadmap : CapabilityRoadmapEntry {
      attribute :>> capability = "C1 Integrated Operational Area Analysis";
      attribute :>> r1Status = "Basic";
      attribute :>> r2Status = "Advanced Fusion";
      attribute :>> r3Status = "Real-time Extension";
    }

    part c2Roadmap : CapabilityRoadmapEntry {
      attribute :>> capability = "C2 Mission Control Concept Analysis";
      attribute :>> r1Status = "Concept/Simulation";
      attribute :>> r2Status = "Initial Operations";
      attribute :>> r3Status = "Advanced Adaptive Control";
    }

    part c3Roadmap : CapabilityRoadmapEntry {
      attribute :>> capability = "C3 Autonomous Collaboration Analysis";
      attribute :>> r1Status = "Concept";
      attribute :>> r2Status = "Pilot";
      attribute :>> r3Status = "Operational";
    }

    part c4Roadmap : CapabilityRoadmapEntry {
      attribute :>> capability = "C4 Survivability/Security Analysis";
      attribute :>> r1Status = "Baseline";
      attribute :>> r2Status = "Enhanced";
      attribute :>> r3Status = "Advanced";
    }
  }

  // ============================================================================
  // P2. OPERATIONAL DOMAIN (WHAT)
  // ============================================================================

  package P2_Operational {

    // ---------- Static: Performer Structure (Definition/Structure) ----------

    part def MannedAircraft :> Performer {
      doc /* Manned aircraft platform with pilot */
      attribute :>> id = "PFM-001";
      attribute :>> name = "Manned Aircraft";
      attribute :>> description = "Manned aircraft with avionics, sensors, and datalink";
    }

    part def UAV :> Performer {
      doc /* Unmanned Aerial Vehicle */
      attribute :>> id = "PFM-002";
      attribute :>> name = "UAV";
      attribute :>> description = "Unmanned aerial vehicle with autonomous capabilities";
    }

    part def UCAV :> Performer {
      doc /* Unmanned Combat Aerial Vehicle */
      attribute :>> id = "PFM-003";
      attribute :>> name = "UCAV";
      attribute :>> description = "Unmanned combat aerial vehicle with weapons capability";
    }

    part def UGV :> Performer {
      doc /* Unmanned Ground Vehicle (optional) */
      attribute :>> id = "PFM-004";
      attribute :>> name = "UGV";
      attribute :>> description = "Unmanned ground vehicle for ground operations";
    }

    part def MissionControlCenter :> Performer {
      doc /* Mission Control Center */
      attribute :>> id = "PFM-005";
      attribute :>> name = "Mission Control Center (MCC)";
      attribute :>> description = "Ground-based mission control and coordination center";
    }

    part def DataLinkRelay :> Performer {
      doc /* Data link relay node */
      attribute :>> id = "PFM-006";
      attribute :>> name = "Data Link Relay Node";
      attribute :>> description = "Communication relay for extended range and redundancy";
    }

    // Needlines (Information Exchange)
    part def NL_SensorData :> CommunicationPath {
      attribute :>> id = "NL-001";
      attribute :>> name = "Sensor Data Needline";
      attribute :>> description = "Sensor data exchange between platforms";
    }

    part def NL_ControlStatus :> CommunicationPath {
      attribute :>> id = "NL-002";
      attribute :>> name = "Control/Status Needline";
      attribute :>> description = "Control commands and status information";
    }

    part def NL_CoopPlan :> CommunicationPath {
      attribute :>> id = "NL-003";
      attribute :>> name = "Cooperation Plan Needline";
      attribute :>> description = "Cooperative planning information exchange";
    }

    part def NL_SecurityAlert :> CommunicationPath {
      attribute :>> id = "NL-004";
      attribute :>> name = "Security Alert Needline";
      attribute :>> description = "Security status and alert information";
    }

    part mumtPerformerStructure : PerformerStructure {
      attribute :>> id = "MUMT-PFM-STRUCT";
      attribute :>> name = "MUMT Performer Structure";
      attribute :>> description = "Performers and information exchange paths for MUMT";
      attribute :>> domainType = DomainKind::Operational;
      attribute :>> concernType = ConcernKind::Static;
      attribute :>> stakeholderQuestion = "What performers exist and how do they exchange information in MUMT?";

      part mannedAircraft : MannedAircraft;
      part uav : UAV;
      part ucav : UCAV;
      part ugv : UGV;
      part mcc : MissionControlCenter;
      part relay : DataLinkRelay;

      part nlSensor : NL_SensorData;
      part nlControl : NL_ControlStatus;
      part nlCoop : NL_CoopPlan;
      part nlSecurity : NL_SecurityAlert;
    }

    // ---------- Dynamic: Operational Activities (Activity/Interaction) ----------

    action def OA1_DataCollection :> OperationalActivity {
      doc /* Operational Area Data Collection/Normalization */
      attribute :>> id = "OA-001";
      attribute :>> name = "OA1: Data Collection/Normalization";
      attribute :>> description = "Collect and normalize sensor and intelligence data";
    }

    action def OA2_IntegratedAssessment :> OperationalActivity {
      doc /* Integrated Assessment/Risk Evaluation */
      attribute :>> id = "OA-002";
      attribute :>> name = "OA2: Integrated Assessment";
      attribute :>> description = "Fuse data and assess threats/risks";
    }

    action def OA3_MissionAllocation :> OperationalActivity {
      doc /* Mission Allocation/Control (Human-Machine Collaboration) */
      attribute :>> id = "OA-003";
      attribute :>> name = "OA3: Mission Allocation/Control";
      attribute :>> description = "Allocate tasks with human-in-the-loop approval";
    }

    action def OA4_AutonomousExecution :> OperationalActivity {
      doc /* Autonomous Collaboration Execution/Replanning */
      attribute :>> id = "OA-004";
      attribute :>> name = "OA4: Autonomous Execution/Replan";
      attribute :>> description = "Execute cooperative tasks and replan as needed";
    }

    action def OA5_SecurityMonitoring :> OperationalActivity {
      doc /* Survivability/Security Monitoring/Response */
      attribute :>> id = "OA-005";
      attribute :>> name = "OA5: Security Monitoring/Response";
      attribute :>> description = "Monitor security status and respond to threats";
    }

    part mumtOperationalScenario : OperationalScenario {
      attribute :>> id = "MUMT-OP-SCENARIO";
      attribute :>> name = "MUMT Operational Scenario";
      attribute :>> description = "Operational activities and interactions for MUMT";
      attribute :>> domainType = DomainKind::Operational;
      attribute :>> concernType = ConcernKind::Dynamic;
      attribute :>> stakeholderQuestion = "What do MUMT performers do and how do they interact?";

      action oa1 : OA1_DataCollection;
      action oa2 : OA2_IntegratedAssessment;
      action oa3 : OA3_MissionAllocation;
      action oa4 : OA4_AutonomousExecution;
      action oa5 : OA5_SecurityMonitoring;
    }

    // ---------- Contracts: Business Rules and Information Standards ----------

    // Business Rules
    requirement def BR_HumanApproval :> Requirement {
      doc /* Human approval required when classification confidence < threshold */
      attribute :>> id = "BR-001";
      attribute :>> name = "Human Approval Rule";
      attribute :>> description = "If classification confidence < θ, human approval is required";
    }

    requirement def BR_CryptoEscalation :> Requirement {
      doc /* Escalate encryption when risk exceeds threshold */
      attribute :>> id = "BR-002";
      attribute :>> name = "Crypto Escalation Rule";
      attribute :>> description = "If risk > R_thr, escalate control link encryption strength";
    }

    // Information Items (Message Types)
    part def MSG_Track :> OperationalItem {
      attribute :>> id = "MSG-001";
      attribute :>> name = "Track Message";
      attribute :>> description = "Target track information";
    }

    part def MSG_Tasking :> OperationalItem {
      attribute :>> id = "MSG-002";
      attribute :>> name = "Tasking Message";
      attribute :>> description = "Mission task assignment";
    }

    part def MSG_CoopPlan :> OperationalItem {
      attribute :>> id = "MSG-003";
      attribute :>> name = "Cooperation Plan Message";
      attribute :>> description = "Cooperative plan information";
    }

    part def MSG_HealthSecAlert :> OperationalItem {
      attribute :>> id = "MSG-004";
      attribute :>> name = "Health/Security Alert Message";
      attribute :>> description = "Platform health and security alert";
    }

    part mumtOperationalContract : OperationalContract {
      attribute :>> id = "MUMT-OP-CONTRACT";
      attribute :>> name = "MUMT Operational Contract";
      attribute :>> description = "Business rules and information standards for MUMT";
      attribute :>> domainType = DomainKind::Operational;
      attribute :>> concernType = ConcernKind::Contracts;
      attribute :>> stakeholderQuestion = "What rules and policies govern MUMT operations?";

      part msgTrack : MSG_Track;
      part msgTasking : MSG_Tasking;
      part msgCoopPlan : MSG_CoopPlan;
      part msgHealthSec : MSG_HealthSecAlert;

      requirement brHumanApproval : BR_HumanApproval;
      requirement brCryptoEscalation : BR_CryptoEscalation;
    }
  }

  // ============================================================================
  // P3. SERVICE DOMAIN (HOW-AS-A-SERVICE)
  // ============================================================================

  package P3_Service {

    // ---------- Static: Service Specifications (Definition/Structure) ----------

    part def S1_FusionService :> Component {
      doc /* Multi-sensor fusion and threat assessment service */
      attribute :>> id = "SVC-S1";
      attribute :>> name = "S1 Fusion Service";
      attribute :>> description = "Multi-sensor data fusion and threat assessment";

      part providedPort : Port {
        attribute :>> id = "S1-PP";
        attribute :>> name = "FusionProvided";
        attribute :>> description = "Provides fused track and threat data";
      }

      part requiredPort : Port {
        attribute :>> id = "S1-RP";
        attribute :>> name = "SensorRequired";
        attribute :>> description = "Requires raw sensor data";
      }
    }

    part def S2_MissionControlService :> Component {
      doc /* Mission planning, allocation, and monitoring service */
      attribute :>> id = "SVC-S2";
      attribute :>> name = "S2 Mission Control Service";
      attribute :>> description = "Mission planning, task allocation, and HIL approval workflow";

      part providedPort : Port {
        attribute :>> id = "S2-PP";
        attribute :>> name = "ControlProvided";
        attribute :>> description = "Provides mission control commands";
      }

      part requiredPort : Port {
        attribute :>> id = "S2-RP";
        attribute :>> name = "FusionRequired";
        attribute :>> description = "Requires fused assessment data";
      }
    }

    part def S3_CoopService :> Component {
      doc /* Distributed cooperation planning and consensus service */
      attribute :>> id = "SVC-S3";
      attribute :>> name = "S3 Cooperation Service";
      attribute :>> description = "Distributed cooperative planning, consensus, and conflict resolution";

      part providedPort : Port {
        attribute :>> id = "S3-PP";
        attribute :>> name = "CoopProvided";
        attribute :>> description = "Provides cooperation plan";
      }

      part requiredPort : Port {
        attribute :>> id = "S3-RP";
        attribute :>> name = "TaskingRequired";
        attribute :>> description = "Requires tasking commands";
      }
    }

    part def S4_SecAssuranceService :> Component {
      doc /* Security monitoring, encryption, and anomaly detection service */
      attribute :>> id = "SVC-S4";
      attribute :>> name = "S4 Security Assurance Service";
      attribute :>> description = "Security monitoring, encryption, key rotation, and intrusion detection";

      part providedPort : Port {
        attribute :>> id = "S4-PP";
        attribute :>> name = "SecProvided";
        attribute :>> description = "Provides security status and policy decisions";
      }

      part requiredPort : Port {
        attribute :>> id = "S4-RP";
        attribute :>> name = "AuditRequired";
        attribute :>> description = "Requires audit and monitoring data";
      }
    }

    part mumtServiceCatalog : ServiceCatalog {
      attribute :>> id = "MUMT-SVC-CATALOG";
      attribute :>> name = "MUMT Service Catalog";
      attribute :>> description = "Service specifications for MUMT";
      attribute :>> domainType = DomainKind::Service;
      attribute :>> concernType = ConcernKind::Static;
      attribute :>> stakeholderQuestion = "What services exist and what interfaces do they expose for MUMT?";

      part s1Fusion : S1_FusionService;
      part s2Control : S2_MissionControlService;
      part s3Coop : S3_CoopService;
      part s4Sec : S4_SecAssuranceService;
    }

    // ---------- Dynamic: Service Orchestration (Interaction/Activity) ----------

    action def SO_FusionToControl :> Function {
      attribute :>> id = "SO-001";
      attribute :>> name = "Fusion to Control";
      attribute :>> description = "S1 provides fused results to S2";
    }

    action def SO_ControlToCoop :> Function {
      attribute :>> id = "SO-002";
      attribute :>> name = "Control to Coop";
      attribute :>> description = "S2 provides tasking to S3";
    }

    action def SO_CoopToSec :> Function {
      attribute :>> id = "SO-003";
      attribute :>> name = "Coop to Security";
      attribute :>> description = "S3 provides coop plan to S4 for audit";
    }

    action def SO_SecToControl :> Function {
      attribute :>> id = "SO-004";
      attribute :>> name = "Security to Control";
      attribute :>> description = "S4 provides policy approval to S2";
    }

    part mumtServiceOrchestration : ServiceOrchestration {
      attribute :>> id = "MUMT-SVC-ORCH";
      attribute :>> name = "MUMT Service Orchestration";
      attribute :>> description = "Service interaction sequences for MUMT";
      attribute :>> domainType = DomainKind::Service;
      attribute :>> concernType = ConcernKind::Dynamic;
      attribute :>> stakeholderQuestion = "How do MUMT services interact and orchestrate?";

      action fusionToControl : SO_FusionToControl;
      action controlToCoop : SO_ControlToCoop;
      action coopToSec : SO_CoopToSec;
      action secToControl : SO_SecToControl;
    }

    // ---------- Contracts: API Schemas and SLAs ----------

    // API Schema Definition
    part def MUMT_MSG_Schema :> ServiceContract {
      doc /* MUMT-MSG v1 Schema: Track/Tasking/Plan/SecAlert */
      attribute :>> id = "API-001";
      attribute :>> name = "MUMT-MSG v1 Schema";
      attribute :>> description = "Message schema for MUMT services (gRPC/REST, STANAG/ROS2 compatible)";
    }

    // SLA Definitions
    part def SLA_S1_Fusion :> VerificationCriterion {
      attribute :>> id = "SLA-S1";
      attribute :>> name = "S1 Fusion SLA";
      attribute :>> description = "Latency p95 ≤ 800ms, Availability ≥ 99.5%, Data integrity and source tracking required";
      attribute latencyP95 : Real = 800.0;
      attribute availability : Real = 99.5;
    }

    part def SLA_S2_Control :> VerificationCriterion {
      attribute :>> id = "SLA-S2";
      attribute :>> name = "S2 Control SLA";
      attribute :>> description = "Latency p95 ≤ 500ms, Availability ≥ 99.9%, Approval required, audit log, RBAC";
      attribute latencyP95 : Real = 500.0;
      attribute availability : Real = 99.9;
    }

    part def SLA_S3_Coop :> VerificationCriterion {
      attribute :>> id = "SLA-S3";
      attribute :>> name = "S3 Coop SLA";
      attribute :>> description = "Latency p95 ≤ 700ms, Availability ≥ 99.7%, Immutable consensus log, time sync";
      attribute latencyP95 : Real = 700.0;
      attribute availability : Real = 99.7;
    }

    part def SLA_S4_Sec :> VerificationCriterion {
      attribute :>> id = "SLA-S4";
      attribute :>> name = "S4 Security SLA";
      attribute :>> description = "Latency p95 ≤ 300ms, Availability ≥ 99.9%, AES-256, key rotation ≤ 24h";
      attribute latencyP95 : Real = 300.0;
      attribute availability : Real = 99.9;
    }

    part mumtServiceContract : ServiceContractArtifact {
      attribute :>> id = "MUMT-SVC-CONTRACT";
      attribute :>> name = "MUMT Service Contract";
      attribute :>> description = "API schemas and SLAs for MUMT services";
      attribute :>> domainType = DomainKind::Service;
      attribute :>> concernType = ConcernKind::Contracts;
      attribute :>> stakeholderQuestion = "What are the API contracts and SLAs for MUMT services?";

      part apiSchema : MUMT_MSG_Schema;
      part slaS1 : SLA_S1_Fusion;
      part slaS2 : SLA_S2_Control;
      part slaS3 : SLA_S3_Coop;
      part slaS4 : SLA_S4_Sec;
    }
  }

  // ============================================================================
  // P4. RESOURCE DOMAIN (WITH WHAT)
  // ============================================================================

  package P4_Resource {

    // ---------- Static: System Configuration (Definition/Structure) ----------

    // Aviation Platform Resources
    part def AviationPlatform :> Component {
      doc /* Aviation platform with avionics, sensors, and datalink */
      attribute :>> id = "RES-001";
      attribute :>> name = "Aviation Platform";
      attribute :>> description = "Manned aircraft platform with integrated systems";

      part avionics : Component {
        attribute :>> id = "RES-001-A";
        attribute :>> name = "Avionics Suite";
        attribute :>> description = "Flight management and mission systems";
      }

      part sensorPackage : Component {
        attribute :>> id = "RES-001-S";
        attribute :>> name = "Sensor Package";
        attribute :>> description = "Multi-spectral sensor suite";
      }

      part dataLinkModule : Component {
        attribute :>> id = "RES-001-D";
        attribute :>> name = "Data Link Module";
        attribute :>> description = "LOS/BLOS communication module";
      }
    }

    // UxV Resources
    part def UxVPlatform :> Component {
      doc /* Unmanned vehicle platform */
      attribute :>> id = "RES-002";
      attribute :>> name = "UxV Platform";
      attribute :>> description = "Unmanned vehicle with autonomous capabilities";

      part autopilot : Component {
        attribute :>> id = "RES-002-A";
        attribute :>> name = "Autopilot";
        attribute :>> description = "Autonomous flight control system";
      }

      part missionComputer : Component {
        attribute :>> id = "RES-002-M";
        attribute :>> name = "Mission Computer";
        attribute :>> description = "Onboard mission processing unit";
      }

      part securityModule : Component {
        attribute :>> id = "RES-002-S";
        attribute :>> name = "Security Module (HSM)";
        attribute :>> description = "Hardware security module for crypto operations";
      }
    }

    // Ground Resources
    part def MCCServer :> Component {
      doc /* Mission Control Center server infrastructure */
      attribute :>> id = "RES-003";
      attribute :>> name = "MCC Server";
      attribute :>> description = "Ground-based mission control server";
    }

    part def EdgeGateway :> Component {
      doc /* Edge gateway for local processing */
      attribute :>> id = "RES-004";
      attribute :>> name = "Edge Gateway";
      attribute :>> description = "Edge computing gateway for distributed processing";
    }

    part def KMS :> Component {
      doc /* Key Management System */
      attribute :>> id = "RES-005";
      attribute :>> name = "Key Management System";
      attribute :>> description = "Cryptographic key management infrastructure";
    }

    part def IDS_IPS :> Component {
      doc /* Intrusion Detection/Prevention System */
      attribute :>> id = "RES-006";
      attribute :>> name = "IDS/IPS";
      attribute :>> description = "Network intrusion detection and prevention";
    }

    part mumtSystemConfig : SystemConfiguration {
      attribute :>> id = "MUMT-SYS-CONFIG";
      attribute :>> name = "MUMT System Configuration";
      attribute :>> description = "System resources and physical interfaces for MUMT";
      attribute :>> domainType = DomainKind::Resource;
      attribute :>> concernType = ConcernKind::Static;
      attribute :>> stakeholderQuestion = "What systems exist and how are they connected in MUMT?";

      part aviationPlatform : AviationPlatform;
      part uxvPlatform : UxVPlatform;
      part mccServer : MCCServer;
      part edgeGateway : EdgeGateway;
      part kms : KMS;
      part idsIps : IDS_IPS;
    }

    // ---------- Dynamic: Resource Behavior (Interaction/StateMachine) ----------

    // Link State Machine
    action def LinkState_Normal :> State {
      attribute :>> id = "LS-001";
      attribute :>> name = "Normal";
      attribute :>> description = "Normal link operation";
    }

    action def LinkState_Jammed :> State {
      attribute :>> id = "LS-002";
      attribute :>> name = "Jammed";
      attribute :>> description = "Link under jamming interference";
    }

    action def LinkState_AltPath :> State {
      attribute :>> id = "LS-003";
      attribute :>> name = "Alternative Path";
      attribute :>> description = "Using alternative communication path";
    }

    action def LinkState_Down :> State {
      attribute :>> id = "LS-004";
      attribute :>> name = "Down";
      attribute :>> description = "Link disconnected";
    }

    // State Transitions
    action def Trans_JammingDetected :> Transition {
      attribute :>> id = "TR-001";
      attribute :>> name = "Jamming Detected";
      attribute :>> description = "Transition from Normal to Jammed on jamming detection";
    }

    action def Trans_Reroute :> Transition {
      attribute :>> id = "TR-002";
      attribute :>> name = "Reroute";
      attribute :>> description = "Transition from Jammed to AltPath on reroute";
    }

    action def Trans_Recovered :> Transition {
      attribute :>> id = "TR-003";
      attribute :>> name = "Recovered";
      attribute :>> description = "Transition from AltPath to Normal on recovery";
    }

    action def Trans_LinkLoss :> Transition {
      attribute :>> id = "TR-004";
      attribute :>> name = "Link Loss";
      attribute :>> description = "Transition from Normal to Down on link loss";
    }

    action def Trans_Reconnect :> Transition {
      attribute :>> id = "TR-005";
      attribute :>> name = "Reconnect";
      attribute :>> description = "Transition from Down to Normal on reconnection";
    }

    part mumtResourceBehavior : ResourceBehavior {
      attribute :>> id = "MUMT-RES-BEHAVIOR";
      attribute :>> name = "MUMT Resource Behavior";
      attribute :>> description = "Resource states and transitions for MUMT";
      attribute :>> domainType = DomainKind::Resource;
      attribute :>> concernType = ConcernKind::Dynamic;
      attribute :>> stakeholderQuestion = "How do MUMT resources behave and what states do they exhibit?";

      action stateNormal : LinkState_Normal;
      action stateJammed : LinkState_Jammed;
      action stateAltPath : LinkState_AltPath;
      action stateDown : LinkState_Down;

      action transJamming : Trans_JammingDetected;
      action transReroute : Trans_Reroute;
      action transRecovered : Trans_Recovered;
      action transLinkLoss : Trans_LinkLoss;
      action transReconnect : Trans_Reconnect;
    }

    // ---------- Contracts: Technical Standards and Data Models ----------

    // Data Models
    part def DM_Telemetry :> Item {
      attribute :>> id = "DM-001";
      attribute :>> name = "Telemetry Data Model";
      attribute :>> description = "Platform telemetry data structure";
    }

    part def DM_Track :> Item {
      attribute :>> id = "DM-002";
      attribute :>> name = "Track Data Model";
      attribute :>> description = "Target track data structure";
    }

    part def DM_Tasking :> Item {
      attribute :>> id = "DM-003";
      attribute :>> name = "Tasking Data Model";
      attribute :>> description = "Mission tasking data structure";
    }

    part def DM_Plan :> Item {
      attribute :>> id = "DM-004";
      attribute :>> name = "Plan Data Model";
      attribute :>> description = "Cooperation plan data structure";
    }

    part def DM_SecEvent :> Item {
      attribute :>> id = "DM-005";
      attribute :>> name = "Security Event Data Model";
      attribute :>> description = "Security event data structure";
    }

    // Technical Standards
    part def STD_AviationPlatform :> Document {
      attribute :>> id = "STD-001";
      attribute :>> name = "Aviation Platform Standards";
      attribute :>> description = "STANAG-XXX, DO-178C compliance";
    }

    part def STD_UxVMissionComputer :> Document {
      attribute :>> id = "STD-002";
      attribute :>> name = "UxV Mission Computer Standards";
      attribute :>> description = "ROS2, DDS-XRCE compliance";
    }

    part def STD_MCCServer :> Document {
      attribute :>> id = "STD-003";
      attribute :>> name = "MCC Server Standards";
      attribute :>> description = "ISO-27001, NIST-800-53 compliance";
    }

    // Performance Constraints
    part def PERF_AviationPlatform :> VerificationCriterion {
      attribute :>> id = "PERF-001";
      attribute :>> name = "Aviation Platform Performance";
      attribute :>> description = "Throughput ≥ 50 Mbps, LOS/BLOS link, AES-256/GCM";
      attribute throughput : Real = 50.0;
      attribute cryptoStrength : String = "AES-256/GCM";
    }

    part def PERF_UxVMissionComputer :> VerificationCriterion {
      attribute :>> id = "PERF-002";
      attribute :>> name = "UxV Mission Computer Performance";
      attribute :>> description = "Processing ≥ 20 TOPS, UHF/L-band link, AES-256";
      attribute processingPower : Real = 20.0;
      attribute cryptoStrength : String = "AES-256";
    }

    part def PERF_MCCServer :> VerificationCriterion {
      attribute :>> id = "PERF-003";
      attribute :>> name = "MCC Server Performance";
      attribute :>> description = "Throughput ≥ 10k msg/s, multi-path link, TLS1.3";
      attribute throughput : Real = 10000.0;
      attribute cryptoStrength : String = "TLS1.3";
    }

    part mumtResourceContract : ResourceContract {
      attribute :>> id = "MUMT-RES-CONTRACT";
      attribute :>> name = "MUMT Resource Contract";
      attribute :>> description = "Technical standards and data models for MUMT resources";
      attribute :>> domainType = DomainKind::Resource;
      attribute :>> concernType = ConcernKind::Contracts;
      attribute :>> stakeholderQuestion = "What standards and data models govern MUMT resources?";

      part dmTelemetry : DM_Telemetry;
      part dmTrack : DM_Track;
      part dmTasking : DM_Tasking;
      part dmPlan : DM_Plan;
      part dmSecEvent : DM_SecEvent;

      part stdAviation : STD_AviationPlatform;
      part stdUxV : STD_UxVMissionComputer;
      part stdMCC : STD_MCCServer;

      part perfAviation : PERF_AviationPlatform;
      part perfUxV : PERF_UxVMissionComputer;
      part perfMCC : PERF_MCCServer;
    }
  }

  // ============================================================================
  // P5. PROJECT DOMAIN (WHEN)
  // ============================================================================

  package P5_Project {

    // ---------- Static: WBS/Project Structure (Definition) ----------

    action def W1_IntegratedAreaAnalysisModule :> ProjectUnit {
      attribute :>> id = "WBS-W1";
      attribute :>> name = "W1 Integrated Area Analysis Module";
      attribute :>> description = "Development of integrated operational area analysis capability";
    }

    action def W2_MissionControlModule :> ProjectUnit {
      attribute :>> id = "WBS-W2";
      attribute :>> name = "W2 Mission Control Module";
      attribute :>> description = "Development of mission control capability";
    }

    action def W3_AutonomousCoopModule :> ProjectUnit {
      attribute :>> id = "WBS-W3";
      attribute :>> name = "W3 Autonomous Cooperation Module";
      attribute :>> description = "Development of autonomous collaboration capability";
    }

    action def W4_SecurityAssuranceModule :> ProjectUnit {
      attribute :>> id = "WBS-W4";
      attribute :>> name = "W4 Security Assurance Module";
      attribute :>> description = "Development of security assurance capability";
    }

    action def W5_IntegrationTest :> ProjectUnit {
      attribute :>> id = "WBS-W5";
      attribute :>> name = "W5 Integration/Test";
      attribute :>> description = "System integration and verification testing";
    }

    part mumtProjectStructure : ProjectStructure {
      attribute :>> id = "MUMT-PRJ-STRUCT";
      attribute :>> name = "MUMT Project Structure";
      attribute :>> description = "WBS decomposition for MUMT project";
      attribute :>> domainType = DomainKind::Project;
      attribute :>> concernType = ConcernKind::Static;
      attribute :>> stakeholderQuestion = "How is the MUMT project organized?";

      action w1 : W1_IntegratedAreaAnalysisModule;
      action w2 : W2_MissionControlModule;
      action w3 : W3_AutonomousCoopModule;
      action w4 : W4_SecurityAssuranceModule;
      action w5 : W5_IntegrationTest;
    }

    // ---------- Dynamic: Project Workflow (Activity) ----------

    action def PW_W1_Development :> ProjectAction {
      attribute :>> id = "PW-001";
      attribute :>> name = "W1 Development";
      attribute :>> description = "Develop integrated area analysis module";
    }

    action def PW_W2_Development :> ProjectAction {
      attribute :>> id = "PW-002";
      attribute :>> name = "W2 Development";
      attribute :>> description = "Develop mission control module";
    }

    action def PW_W3_Development :> ProjectAction {
      attribute :>> id = "PW-003";
      attribute :>> name = "W3 Development";
      attribute :>> description = "Develop autonomous cooperation module";
    }

    action def PW_W4_Development :> ProjectAction {
      attribute :>> id = "PW-004";
      attribute :>> name = "W4 Development";
      attribute :>> description = "Develop security assurance module (parallel)";
    }

    action def PW_W5_Integration :> ProjectAction {
      attribute :>> id = "PW-005";
      attribute :>> name = "W5 Integration";
      attribute :>> description = "System integration and testing";
    }

    part mumtProjectWorkflow : ProjectWorkflow {
      attribute :>> id = "MUMT-PRJ-WORKFLOW";
      attribute :>> name = "MUMT Project Workflow";
      attribute :>> description = "Project activity flow: W1→W2→W3, W4 parallel, W5 integration";
      attribute :>> domainType = DomainKind::Project;
      attribute :>> concernType = ConcernKind::Dynamic;
      attribute :>> stakeholderQuestion = "What is the MUMT project schedule and critical path?";

      action pwW1 : PW_W1_Development;
      action pwW2 : PW_W2_Development;
      action pwW3 : PW_W3_Development;
      action pwW4 : PW_W4_Development;
      action pwW5 : PW_W5_Integration;

      // Dependencies: W1 → W2 → W3, W4 parallel, all → W5
    }

    // ---------- Contracts: Milestones and DoD ----------

    part def M1_Milestone :> VerificationMilestone {
      attribute :>> id = "MS-M1";
      attribute :>> name = "M1 Milestone";
      attribute :>> description = "R1: C1 Basic, S1 Draft, Resource Baseline";
      attribute release : String = "R1";
    }

    part def M2_Milestone :> VerificationMilestone {
      attribute :>> id = "MS-M2";
      attribute :>> name = "M2 Milestone";
      attribute :>> description = "R2: C2 Initial Ops, S2/S3 Pilot, Link Redundancy";
      attribute release : String = "R2";
    }

    part def M3_Milestone :> VerificationMilestone {
      attribute :>> id = "MS-M3";
      attribute :>> name = "M3 Milestone";
      attribute :>> description = "R3: C3/C4 Operational, SLA/Security Advanced, Full Verification";
      attribute release : String = "R3";
    }

    // Definition of Done
    part def DoD_M1 :> VerificationCriterion {
      attribute :>> id = "DOD-M1";
      attribute :>> name = "M1 Definition of Done";
      attribute :>> description = "C1 basic capability verified, S1 interface draft approved, resource baseline established";
    }

    part def DoD_M2 :> VerificationCriterion {
      attribute :>> id = "DOD-M2";
      attribute :>> name = "M2 Definition of Done";
      attribute :>> description = "C2 initial operations verified, S2/S3 pilot tested, link redundancy demonstrated";
    }

    part def DoD_M3 :> VerificationCriterion {
      attribute :>> id = "DOD-M3";
      attribute :>> name = "M3 Definition of Done";
      attribute :>> description = "C3/C4 operational capability verified, SLA compliance demonstrated, security audit passed";
    }

    part mumtProjectContract : ProjectContract {
      attribute :>> id = "MUMT-PRJ-CONTRACT";
      attribute :>> name = "MUMT Project Contract";
      attribute :>> description = "Milestones and acceptance criteria for MUMT project";
      attribute :>> domainType = DomainKind::Project;
      attribute :>> concernType = ConcernKind::Contracts;
      attribute :>> stakeholderQuestion = "What are the acceptance criteria for each MUMT milestone?";

      part m1 : M1_Milestone;
      part m2 : M2_Milestone;
      part m3 : M3_Milestone;

      part dodM1 : DoD_M1;
      part dodM2 : DoD_M2;
      part dodM3 : DoD_M3;
    }
  }

  // ============================================================================
  // P6. RELATIONSHIPS & TRACEABILITY
  // ============================================================================

  package P6_Relationships {

    // ==========================================================================
    // Performer → OperationalActivity (Performs)
    // Defines which performer performs which operational activity
    // ==========================================================================

    connection mannedAircraftPerformsOA1 : Performs {
      end structure ::> P2_Operational::mumtPerformerStructure.mannedAircraft;
      end behavior ::> P2_Operational::mumtOperationalScenario.oa1;
    }

    connection mannedAircraftPerformsOA3 : Performs {
      end structure ::> P2_Operational::mumtPerformerStructure.mannedAircraft;
      end behavior ::> P2_Operational::mumtOperationalScenario.oa3;
    }

    connection uavPerformsOA1 : Performs {
      end structure ::> P2_Operational::mumtPerformerStructure.uav;
      end behavior ::> P2_Operational::mumtOperationalScenario.oa1;
    }

    connection uavPerformsOA4 : Performs {
      end structure ::> P2_Operational::mumtPerformerStructure.uav;
      end behavior ::> P2_Operational::mumtOperationalScenario.oa4;
    }

    connection ucavPerformsOA1 : Performs {
      end structure ::> P2_Operational::mumtPerformerStructure.ucav;
      end behavior ::> P2_Operational::mumtOperationalScenario.oa1;
    }

    connection ucavPerformsOA4 : Performs {
      end structure ::> P2_Operational::mumtPerformerStructure.ucav;
      end behavior ::> P2_Operational::mumtOperationalScenario.oa4;
    }

    connection mccPerformsOA2 : Performs {
      end structure ::> P2_Operational::mumtPerformerStructure.mcc;
      end behavior ::> P2_Operational::mumtOperationalScenario.oa2;
    }

    connection mccPerformsOA3 : Performs {
      end structure ::> P2_Operational::mumtPerformerStructure.mcc;
      end behavior ::> P2_Operational::mumtOperationalScenario.oa3;
    }

    connection mccPerformsOA5 : Performs {
      end structure ::> P2_Operational::mumtPerformerStructure.mcc;
      end behavior ::> P2_Operational::mumtOperationalScenario.oa5;
    }

    // ==========================================================================
    // Capability → OperationalActivity (BasedOn/ResultsIn)
    // Defines which capability is based on or results in which operational activity
    // ==========================================================================

    connection c1BasedOnOA1 : BasedOn {
      end source ::> P1_Strategy::mumtCapabilityTree.c1;
      end target ::> P2_Operational::mumtOperationalScenario.oa1;
    }

    connection c1BasedOnOA2 : BasedOn {
      end source ::> P1_Strategy::mumtCapabilityTree.c1;
      end target ::> P2_Operational::mumtOperationalScenario.oa2;
    }

    connection c2BasedOnOA3 : BasedOn {
      end source ::> P1_Strategy::mumtCapabilityTree.c2;
      end target ::> P2_Operational::mumtOperationalScenario.oa3;
    }

    connection c3BasedOnOA4 : BasedOn {
      end source ::> P1_Strategy::mumtCapabilityTree.c3;
      end target ::> P2_Operational::mumtOperationalScenario.oa4;
    }

    connection c4BasedOnOA5 : BasedOn {
      end source ::> P1_Strategy::mumtCapabilityTree.c4;
      end target ::> P2_Operational::mumtOperationalScenario.oa5;
    }

    // ==========================================================================
    // OperationalTask → OperationalActivity (AchievedBy)
    // Defines which operational task is achieved by which operational activity
    // ==========================================================================

    connection detectAchievedByOA1 : AchievedBy {
      end source ::> P1_Strategy::mumtMissionFlow.detect;
      end target ::> P2_Operational::mumtOperationalScenario.oa1;
    }

    connection fuseAchievedByOA2 : AchievedBy {
      end source ::> P1_Strategy::mumtMissionFlow.fuse;
      end target ::> P2_Operational::mumtOperationalScenario.oa2;
    }

    connection allocateAchievedByOA3 : AchievedBy {
      end source ::> P1_Strategy::mumtMissionFlow.allocates;
      end target ::> P2_Operational::mumtOperationalScenario.oa3;
    }

    connection collaborateAchievedByOA4 : AchievedBy {
      end source ::> P1_Strategy::mumtMissionFlow.collaborate;
      end target ::> P2_Operational::mumtOperationalScenario.oa4;
    }

    connection evaluateAchievedByOA5 : AchievedBy {
      end source ::> P1_Strategy::mumtMissionFlow.evaluate;
      end target ::> P2_Operational::mumtOperationalScenario.oa5;
    }

    // ==========================================================================
    // Performer → Component (ImplementedBy)
    // Defines which performer is implemented by which physical component
    // ==========================================================================

    connection mannedAircraftImplementedBy : ImplementedBy {
      end source ::> P2_Operational::mumtPerformerStructure.mannedAircraft;
      end target ::> P4_Resource::mumtSystemConfig.aviationPlatform;
    }

    connection uavImplementedBy : ImplementedBy {
      end source ::> P2_Operational::mumtPerformerStructure.uav;
      end target ::> P4_Resource::mumtSystemConfig.uxvPlatform;
    }

    connection ucavImplementedBy : ImplementedBy {
      end source ::> P2_Operational::mumtPerformerStructure.ucav;
      end target ::> P4_Resource::mumtSystemConfig.uxvPlatform;
    }

    connection mccImplementedBy : ImplementedBy {
      end source ::> P2_Operational::mumtPerformerStructure.mcc;
      end target ::> P4_Resource::mumtSystemConfig.mccServer;
    }

    connection relayImplementedBy : ImplementedBy {
      end source ::> P2_Operational::mumtPerformerStructure.relay;
      end target ::> P4_Resource::mumtSystemConfig.edgeGateway;
    }

    // ==========================================================================
    // OperationalActivity → Function (ImplementedBy)
    // Defines which operational activity is implemented by which service function
    // ==========================================================================

    connection oa1ImplementedByS1 : ImplementedBy {
      end source ::> P2_Operational::mumtOperationalScenario.oa1;
      end target ::> P3_Service::mumtServiceCatalog.s1Fusion;
    }

    connection oa2ImplementedByS1 : ImplementedBy {
      end source ::> P2_Operational::mumtOperationalScenario.oa2;
      end target ::> P3_Service::mumtServiceCatalog.s1Fusion;
    }

    connection oa3ImplementedByS2 : ImplementedBy {
      end source ::> P2_Operational::mumtOperationalScenario.oa3;
      end target ::> P3_Service::mumtServiceCatalog.s2Control;
    }

    connection oa4ImplementedByS3 : ImplementedBy {
      end source ::> P2_Operational::mumtOperationalScenario.oa4;
      end target ::> P3_Service::mumtServiceCatalog.s3Coop;
    }

    connection oa5ImplementedByS4 : ImplementedBy {
      end source ::> P2_Operational::mumtOperationalScenario.oa5;
      end target ::> P3_Service::mumtServiceCatalog.s4Sec;
    }

    // ==========================================================================
    // CommunicationPath → Performer (ConnectsTo)
    // Defines which communication path connects which performers
    // ==========================================================================

    connection nlSensorConnectsManned : ConnectsTo {
      end source ::> P2_Operational::mumtPerformerStructure.nlSensor;
      end target ::> P2_Operational::mumtPerformerStructure.mannedAircraft;
    }

    connection nlSensorConnectsUAV : ConnectsTo {
      end source ::> P2_Operational::mumtPerformerStructure.nlSensor;
      end target ::> P2_Operational::mumtPerformerStructure.uav;
    }

    connection nlSensorConnectsMCC : ConnectsTo {
      end source ::> P2_Operational::mumtPerformerStructure.nlSensor;
      end target ::> P2_Operational::mumtPerformerStructure.mcc;
    }

    connection nlControlConnectsMCC : ConnectsTo {
      end source ::> P2_Operational::mumtPerformerStructure.nlControl;
      end target ::> P2_Operational::mumtPerformerStructure.mcc;
    }

    connection nlControlConnectsUAV : ConnectsTo {
      end source ::> P2_Operational::mumtPerformerStructure.nlControl;
      end target ::> P2_Operational::mumtPerformerStructure.uav;
    }

    connection nlControlConnectsUCAV : ConnectsTo {
      end source ::> P2_Operational::mumtPerformerStructure.nlControl;
      end target ::> P2_Operational::mumtPerformerStructure.ucav;
    }

    connection nlCoopConnectsUAV : ConnectsTo {
      end source ::> P2_Operational::mumtPerformerStructure.nlCoop;
      end target ::> P2_Operational::mumtPerformerStructure.uav;
    }

    connection nlCoopConnectsUCAV : ConnectsTo {
      end source ::> P2_Operational::mumtPerformerStructure.nlCoop;
      end target ::> P2_Operational::mumtPerformerStructure.ucav;
    }

    connection nlSecurityConnectsMCC : ConnectsTo {
      end source ::> P2_Operational::mumtPerformerStructure.nlSecurity;
      end target ::> P2_Operational::mumtPerformerStructure.mcc;
    }

    // ==========================================================================
    // CommunicationPath → OperationalItem (Transfers)
    // Defines which communication path transfers which information item
    // ==========================================================================

    connection nlSensorTransfersTrack : Transfers {
      end source ::> P2_Operational::mumtPerformerStructure.nlSensor;
      end target ::> P2_Operational::mumtOperationalContract.msgTrack;
    }

    connection nlControlTransfersTasking : Transfers {
      end source ::> P2_Operational::mumtPerformerStructure.nlControl;
      end target ::> P2_Operational::mumtOperationalContract.msgTasking;
    }

    connection nlCoopTransfersPlan : Transfers {
      end source ::> P2_Operational::mumtPerformerStructure.nlCoop;
      end target ::> P2_Operational::mumtOperationalContract.msgCoopPlan;
    }

    connection nlSecurityTransfersAlert : Transfers {
      end source ::> P2_Operational::mumtPerformerStructure.nlSecurity;
      end target ::> P2_Operational::mumtOperationalContract.msgHealthSec;
    }

    // ==========================================================================
    // Service → Resource (ImplementedBy)
    // Defines which service is implemented/deployed by which resource
    // ==========================================================================

    connection s1ImplementedByMCC : ImplementedBy {
      end source ::> P3_Service::mumtServiceCatalog.s1Fusion;
      end target ::> P4_Resource::mumtSystemConfig.mccServer;
    }

    connection s1ImplementedByUxV : ImplementedBy {
      end source ::> P3_Service::mumtServiceCatalog.s1Fusion;
      end target ::> P4_Resource::mumtSystemConfig.uxvPlatform;
    }

    connection s2ImplementedByMCC : ImplementedBy {
      end source ::> P3_Service::mumtServiceCatalog.s2Control;
      end target ::> P4_Resource::mumtSystemConfig.mccServer;
    }

    connection s3ImplementedByUxV : ImplementedBy {
      end source ::> P3_Service::mumtServiceCatalog.s3Coop;
      end target ::> P4_Resource::mumtSystemConfig.uxvPlatform;
    }

    connection s4ImplementedByKMS : ImplementedBy {
      end source ::> P3_Service::mumtServiceCatalog.s4Sec;
      end target ::> P4_Resource::mumtSystemConfig.kms;
    }

    connection s4ImplementedByIDS : ImplementedBy {
      end source ::> P3_Service::mumtServiceCatalog.s4Sec;
      end target ::> P4_Resource::mumtSystemConfig.idsIps;
    }

    // ==========================================================================
    // Capability → Service (ImplementedBy)
    // Defines which capability is implemented by which service
    // ==========================================================================

    connection c1ImplementedByS1 : ImplementedBy {
      end source ::> P1_Strategy::mumtCapabilityTree.c1;
      end target ::> P3_Service::mumtServiceCatalog.s1Fusion;
    }

    connection c2ImplementedByS2 : ImplementedBy {
      end source ::> P1_Strategy::mumtCapabilityTree.c2;
      end target ::> P3_Service::mumtServiceCatalog.s2Control;
    }

    connection c3ImplementedByS3 : ImplementedBy {
      end source ::> P1_Strategy::mumtCapabilityTree.c3;
      end target ::> P3_Service::mumtServiceCatalog.s3Coop;
    }

    connection c4ImplementedByS4 : ImplementedBy {
      end source ::> P1_Strategy::mumtCapabilityTree.c4;
      end target ::> P3_Service::mumtServiceCatalog.s4Sec;
    }

    // ==========================================================================
    // Mission → Capability (AchievedBy)
    // Defines which mission is achieved by which capability
    // ==========================================================================

    connection missionAchievedByC1 : AchievedBy {
      end source ::> P1_Strategy::mumtMissionFlow.missionThread;
      end target ::> P1_Strategy::mumtCapabilityTree.c1;
    }

    connection missionAchievedByC2 : AchievedBy {
      end source ::> P1_Strategy::mumtMissionFlow.missionThread;
      end target ::> P1_Strategy::mumtCapabilityTree.c2;
    }

    connection missionAchievedByC3 : AchievedBy {
      end source ::> P1_Strategy::mumtMissionFlow.missionThread;
      end target ::> P1_Strategy::mumtCapabilityTree.c3;
    }

    connection missionAchievedByC4 : AchievedBy {
      end source ::> P1_Strategy::mumtMissionFlow.missionThread;
      end target ::> P1_Strategy::mumtCapabilityTree.c4;
    }

    // ==========================================================================
    // ProjectUnit → Capability (Supplies)
    // Defines which project unit supplies/provides which capability
    // ==========================================================================

    connection w1SuppliesC1 : Supplies {
      end source ::> P5_Project::mumtProjectStructure.w1;
      end target ::> P1_Strategy::mumtCapabilityTree.c1;
    }

    connection w2SuppliesC2 : Supplies {
      end source ::> P5_Project::mumtProjectStructure.w2;
      end target ::> P1_Strategy::mumtCapabilityTree.c2;
    }

    connection w3SuppliesC3 : Supplies {
      end source ::> P5_Project::mumtProjectStructure.w3;
      end target ::> P1_Strategy::mumtCapabilityTree.c3;
    }

    connection w4SuppliesC4 : Supplies {
      end source ::> P5_Project::mumtProjectStructure.w4;
      end target ::> P1_Strategy::mumtCapabilityTree.c4;
    }
  }

  // ============================================================================
  // MUMT S2AF GRID INSTANCE
  // ============================================================================

  part mumtArchitecture : S2AFGrid {
    attribute id = "MUMT-ARCH-001";
    attribute name = "MUMT Architecture";
    attribute description = "Manned-Unmanned Teaming Architecture based on S2AF";
    attribute version = "1.0";

    // Strategy Domain
    part strategyStatic = P1_Strategy::mumtCapabilityTree;
    part strategyDynamic = P1_Strategy::mumtMissionFlow;
    part strategyContracts = P1_Strategy::mumtCapabilityContract;

    // Operational Domain
    part operationalStatic = P2_Operational::mumtPerformerStructure;
    part operationalDynamic = P2_Operational::mumtOperationalScenario;
    part operationalContracts = P2_Operational::mumtOperationalContract;

    // Service Domain
    part serviceStatic = P3_Service::mumtServiceCatalog;
    part serviceDynamic = P3_Service::mumtServiceOrchestration;
    part serviceContracts = P3_Service::mumtServiceContract;

    // Resource Domain
    part resourceStatic = P4_Resource::mumtSystemConfig;
    part resourceDynamic = P4_Resource::mumtResourceBehavior;
    part resourceContracts = P4_Resource::mumtResourceContract;

    // Project Domain
    part projectStatic = P5_Project::mumtProjectStructure;
    part projectDynamic = P5_Project::mumtProjectWorkflow;
    part projectContracts = P5_Project::mumtProjectContract;
  }
}
