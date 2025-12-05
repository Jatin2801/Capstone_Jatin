package com.micro.song.controller;

import com.micro.song.entity.Song;
import com.micro.song.service.SongService;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/songs")
public class SongController {

    private final SongService service;

    public SongController(SongService service) {
        this.service = service;
    }

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public Song save(
            @RequestPart("song") Song song,
            @RequestPart(value = "file", required = false) MultipartFile file
    ) throws IOException {
        return service.saveWithFile(song, file);   // MAIL SENT HERE
    }

    @PostMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
    public Song saveJson(@RequestBody Song s) {
        return service.save(s);   // will NOT send mail unless you add notification
    }

    @GetMapping
    public List<Song> all() {
        return service.all();
    }

    @GetMapping("/search")
    public List<Song> search(@RequestParam String keyword) {
        return service.search(keyword);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Song> get(@PathVariable Integer id) {
        return service.get(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping(value = "/{id}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<Song> update(
            @PathVariable Integer id,
            @RequestPart("song") Song song,
            @RequestPart(value = "file", required = false) MultipartFile file
    ) throws IOException {

         var updated = service.update(id, song, file);

        if (updated == null) return ResponseEntity.notFound().build();

        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Integer id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}/file")
    public ResponseEntity<InputStreamResource> getFile(@PathVariable Integer id) throws IOException {
        var fileInfo = service.getFileResource(id);
        if (fileInfo == null) return ResponseEntity.notFound().build();

        InputStreamResource resource = new InputStreamResource(fileInfo.inputStream());
        HttpHeaders headers = new HttpHeaders();
        headers.setContentDisposition(ContentDisposition.inline().filename(fileInfo.fileName()).build());
        headers.setContentType(MediaType.parseMediaType(fileInfo.fileType() == null ? "audio/mpeg" : fileInfo.fileType()));

        return ResponseEntity.ok()
                .headers(headers)
                .contentLength(fileInfo.fileSize())
                .body(resource);
    }

    public record FileInfo(java.io.InputStream inputStream, String fileName, String fileType, long fileSize) {}
}
