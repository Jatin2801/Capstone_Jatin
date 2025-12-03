package com.web.frontend.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import org.springframework.core.io.FileSystemResource;

import java.io.File;


import java.util.LinkedHashMap;
import java.util.Map;

@Controller
@RequestMapping("/songs")
public class SongUIController {

    private final RestTemplate rest;

    @Value("${SONG_SERVICE_URL}")
    private String URL;

    public SongUIController(RestTemplate rest) {
        this.rest = rest;
    }

    @GetMapping
    public String list(Model model) {
        LinkedHashMap[] songs =
                rest.getForObject(URL + "/songs", LinkedHashMap[].class);
        model.addAttribute("songs", songs);
        return "song-list";
    }

    @GetMapping("/add")
    public String addForm(Model model) {
        model.addAttribute("song", new LinkedHashMap<>());
        model.addAttribute("mode", "Add Song");
        return "song-form";
    }

    @PostMapping("/save")
    public String save(@RequestParam Map<String,String> params,
                       @RequestParam(value="file",required=false) MultipartFile file,
                       Model model) {

        try {
            LinkedMultiValueMap<String,Object> body = new LinkedMultiValueMap<>();

            ObjectMapper mapper = new ObjectMapper();
            String json = mapper.writeValueAsString(params);

            HttpHeaders jsonHeaders = new HttpHeaders();
            jsonHeaders.setContentType(MediaType.APPLICATION_JSON);

            HttpEntity<String> songPart = new HttpEntity<>(json, jsonHeaders);
            body.add("song", songPart);

            if (file != null && !file.isEmpty()) {
                File temp = File.createTempFile("up-", file.getOriginalFilename());
                file.transferTo(temp);
                body.add("file", new FileSystemResource(temp));
            }

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.MULTIPART_FORM_DATA);

            HttpEntity<MultiValueMap<String,Object>> req =
                    new HttpEntity<>(body, headers);

            rest.postForObject(URL + "/songs", req, Object.class);

            return "redirect:/songs";

        } catch (Exception ex) {
            model.addAttribute("error", ex.getMessage());
            return "song-form";
        }
    }


    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Integer id, Model model) {
        LinkedHashMap song =
                rest.getForObject(URL + "/songs/" + id, LinkedHashMap.class);
        model.addAttribute("song", song);
        model.addAttribute("mode", "Edit Song");
        return "song-form";
    }
    
    @GetMapping("/play/{id}")
    public ResponseEntity<byte[]> play(@PathVariable Integer id) {
        ResponseEntity<byte[]> resp =
                rest.getForEntity(URL + "/songs/" + id + "/file", byte[].class);

        HttpHeaders headers = new HttpHeaders();
        headers.putAll(resp.getHeaders());

        return new ResponseEntity<>(resp.getBody(), headers, resp.getStatusCode());
    }


    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id) {
        rest.delete(URL + "/songs/" + id);
        return "redirect:/songs";
    }
}
