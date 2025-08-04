;; VoiceChain Protocol
;;
;; Title: VoiceChain - The Future of Decentralized Social Discourse
;;
;; Summary: A next-generation social protocol that transforms how communities 
;; engage, create, and monetize content through blockchain-native incentive 
;; structures and democratic governance mechanisms.
;;
;; Description: VoiceChain reimagines social interaction by leveraging Bitcoin's 
;; security foundation to create an economic layer for authentic discourse. 
;; The protocol introduces novel mechanisms including reputation-weighted voting, 
;; creator monetization through premium content gates, peer-to-peer value 
;; streaming via tips, and community-driven content curation. By requiring 
;; economic stake for participation, VoiceChain eliminates spam while ensuring 
;; quality discussions flourish through aligned incentives between creators, 
;; curators, and consumers of content.
;;
;; Innovation Highlights:
;; - Economic Participation Model: Stake-based entry barriers ensure serious engagement
;; - Creator Economy Engine: Direct monetization paths for premium discussions
;; - Reputation-Driven Governance: Community standing influences content visibility  
;; - Hierarchical Discussion Trees: Structured conversations with nested replies
;; - Value Distribution Layer: Transparent tip economy for quality content rewards

;; ERROR CONSTANTS

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_OWNER_ONLY (err u100))
(define-constant ERR_NOT_FOUND (err u101))
(define-constant ERR_UNAUTHORIZED (err u102))
(define-constant ERR_INSUFFICIENT_BALANCE (err u103))
(define-constant ERR_INVALID_AMOUNT (err u104))
(define-constant ERR_THREAD_LOCKED (err u105))
(define-constant ERR_ALREADY_VOTED (err u106))
(define-constant ERR_INVALID_TIP (err u107))
(define-constant ERR_SELF_TIP (err u108))
(define-constant ERR_THREAD_NOT_PREMIUM (err u109))
(define-constant ERR_INSUFFICIENT_STAKE (err u110))
(define-constant ERR_INVALID_PARENT_REPLY (err u111))

;; PROTOCOL CONFIGURATION

(define-data-var thread-counter uint u0)
(define-data-var reply-counter uint u0)
(define-data-var min-stake-amount uint u1000000) ;; 1 STX minimum stake
(define-data-var platform-fee-rate uint u250) ;; 2.5% platform fee
(define-data-var platform-treasury principal CONTRACT_OWNER)

;; CORE DATA STRUCTURES

;; Thread Registry - Premium Content Management System
(define-map threads
  { thread-id: uint }
  {
    author: principal,
    title: (string-utf8 256),
    content: (string-utf8 2048),
    is-premium: bool,
    premium-price: uint,
    created-at: uint,
    upvotes: uint,
    downvotes: uint,
    tips-received: uint,
    is-locked: bool,
    reply-count: uint,
  }
)

;; Reply System - Hierarchical Discussion Architecture
(define-map replies
  { reply-id: uint }
  {
    thread-id: uint,
    author: principal,
    content: (string-utf8 1024),
    created-at: uint,
    upvotes: uint,
    downvotes: uint,
    tips-received: uint,
    parent-reply-id: (optional uint),
  }
)

;; Reputation Engine - Community Standing Metrics
(define-map user-reputation
  { user: principal }
  {
    total-upvotes: uint,
    total-downvotes: uint,
    threads-created: uint,
    replies-created: uint,
    tips-sent: uint,
    tips-received: uint,
    staked-amount: uint,
    reputation-score: uint,
  }
)

;; Voting System - Democratic Content Curation Engine
(define-map thread-votes
  {
    thread-id: uint,
    voter: principal,
  }
  { vote-type: bool }
)