package com.web.frontend.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

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
    public String save(@RequestParam Map<String, String> form) {

        Integer id = form.get("libraryId") == null || form.get("libraryId").isEmpty()
                ? null
                : Integer.valueOf(form.get("libraryId"));

        if (id == null) {
            rest.postForObject(URL + "/songs", form, LinkedHashMap.class);
        } else {
            rest.put(URL + "/songs/" + id, form);
        }
        return "redirect:/songs";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Integer id, Model model) {
        LinkedHashMap song =
                rest.getForObject(URL + "/songs/" + id, LinkedHashMap.class);
        model.addAttribute("song", song);
        model.addAttribute("mode", "Edit Song");
        return "song-form";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id) {
        rest.delete(URL + "/songs/" + id);
        return "redirect:/songs";
    }
}
