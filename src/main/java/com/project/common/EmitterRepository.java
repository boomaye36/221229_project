package com.project.common;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Service
public class EmitterRepository {
    private final Map<String, SseEmitter> emitters = new ConcurrentHashMap<>();
    private final Map<String, Object> eventCache = new ConcurrentHashMap<>();

    public SseEmitter save(String emitterId, SseEmitter sseEmitter) {
        emitters.put(emitterId,sseEmitter);
        return sseEmitter;
    }

    public void saveEventCache(String emitterId, Object event) {
        eventCache.put(emitterId,event);
    }

    public Map<String, SseEmitter> findAllStartWithById(String memberId) {
        return emitters.entrySet().stream()
                .filter(entry -> entry.getKey().startsWith(memberId))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }

    public Map<String, Object> findAllEventCacheStartWithId(String memberId) {
        return eventCache.entrySet().stream()
                .filter(entry -> entry.getKey().startsWith(memberId))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }

    public void deleteById(String emitterId) {
        emitters.remove(emitterId);

    }

	/*
	 * @Override public void deleteAllEmitterStartWithId(String memberId) {
	 * emitters.forEach( (key,emitter) -> { if(key.startsWith(memberId)){
	 * emitters.remove(key); } } ); }
	 * 
	 * @Override public void deleteAllEventCacheStartWithId(String memberId) {
	 * eventCache.forEach( (key,emitter) -> { if(key.startsWith(memberId)){
	 * eventCache.remove(key); } } );
	 * 
	 * }
	 */
}