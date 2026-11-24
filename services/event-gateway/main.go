package main

import (
	"encoding/json"
	"log"
	"net/http"
	"time"
)

type Event struct {
	Type     string  `json:"type"`
	Zone     string  `json:"zone"`
	Moisture float64 `json:"moisture,omitempty"`
}

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(map[string]string{"status": "ok", "service": "event-gateway"})
	})
	mux.HandleFunc("/events", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodPost {
			http.Error(w, "POST required", http.StatusMethodNotAllowed)
			return
		}
		defer r.Body.Close()
		var event Event
		if err := json.NewDecoder(r.Body).Decode(&event); err != nil || event.Type == "" || event.Zone == "" {
			http.Error(w, "valid JSON with type and zone required", http.StatusBadRequest)
			return
		}
		log.Printf("event received at %s: %+v", time.Now().Format(time.RFC3339), event)
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusAccepted)
		json.NewEncoder(w).Encode(map[string]any{"accepted": true, "persisted": false, "event": event})
	})
	log.Println("AGRISENTINEL event gateway listening on :8081")
	log.Fatal(http.ListenAndServe(":8081", mux))
}
