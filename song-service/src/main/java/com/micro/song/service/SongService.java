package com.micro.song.service;

import com.micro.song.entity.Song;
import com.micro.song.repository.SongRepository;
import com.micro.song.controller.SongController.FileInfo;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

@Service
public class SongService {

    private final SongRepository repo;
    private final RestTemplate restTemplate;

    @Value("${song.file.storage}")
    private String storageDir;

    @Value("${USER_SERVICE_URL:http://localhost:8081}")
    private String userServiceUrl;

    @Value("${MAIL_SERVICE_URL:http://localhost:8084}")
    private String mailServiceUrl;

    public SongService(SongRepository repo, RestTemplate restTemplate) {
        this.repo = repo;
        this.restTemplate = restTemplate;
    }

    public List<Song> all() {
        return repo.findAll();
    }

    public Optional<Song> get(Integer id) {
        return repo.findById(id);
    }

    public Song save(Song s) {
        return repo.save(s);
    }

    public Song saveWithFile(Song s, MultipartFile file) throws IOException {
        if (file != null && !file.isEmpty()) {
            ensureStorageExists();
            String uniqueName = UUID.randomUUID() + file.getOriginalFilename();
            Path path = Paths.get(storageDir).resolve(uniqueName);
            Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
            s.setFileName(file.getOriginalFilename());
            s.setFileType(file.getContentType());
            s.setFileSize(file.getSize());
            s.setFilePath(path.toString());
        }
        Song saved = repo.save(s);
        notifyAllUsersSongAdded(saved);
        return saved;
    }

    public Song update(Integer id, Song newData, MultipartFile file) throws IOException {
        Optional<Song> opt = repo.findById(id);
        if (opt.isEmpty()) {
            return null;
        }
        Song s = opt.get();
        s.setSongTitle(newData.getSongTitle());
        s.setGenre(newData.getGenre());
        s.setMusicDirector(newData.getMusicDirector());
        s.setSinger(newData.getSinger());
        s.setReleaseDate(newData.getReleaseDate());
        s.setAlbumName(newData.getAlbumName());
        s.setSongType(newData.getSongType());
        s.setSongStatus(newData.getSongStatus());
        if (file != null && !file.isEmpty()) {
            ensureStorageExists();
            if (s.getFilePath() != null) {
                try {
                    Files.deleteIfExists(Paths.get(s.getFilePath()));
                } catch (Exception e) {
                }
            }
            String uniqueName = UUID.randomUUID() + file.getOriginalFilename();
            Path path = Paths.get(storageDir).resolve(uniqueName);
            Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
            s.setFileName(file.getOriginalFilename());
            s.setFileType(file.getContentType());
            s.setFileSize(file.getSize());
            s.setFilePath(path.toString());
        }
        return repo.save(s);
    }

    public void delete(Integer id) {
        repo.deleteById(id);
    }

    public FileInfo getFileResource(Integer id) throws IOException {
        Optional<Song> opt = repo.findById(id);
        if (opt.isEmpty()) {
            return null;
        }
        Song s = opt.get();
        if (s.getFilePath() == null) {
            return null;
        }
        Path path = Paths.get(s.getFilePath());
        if (!Files.exists(path)) {
            return null;
        }
        InputStream in = Files.newInputStream(path, StandardOpenOption.READ);
        return new FileInfo(in, s.getFileName(), s.getFileType(), s.getFileSize());
    }

    public List<Song> search(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return repo.findAll();
        }
        String k = keyword.trim();
        return repo.findBySongTitleContainingIgnoreCaseOrMusicDirectorContainingIgnoreCaseOrSingerContainingIgnoreCase(k, k, k);
    }

    private void ensureStorageExists() throws IOException {
        Path dir = Paths.get(storageDir);
        if (!Files.exists(dir)) {
            Files.createDirectories(dir);
        }
    }

    private void notifyAllUsersSongAdded(Song song) {
        try {
            ResponseEntity<List<Map<String, Object>>> response = restTemplate.exchange(
                    userServiceUrl + "/users/all",
                    HttpMethod.GET,
                    null,
                    new ParameterizedTypeReference<List<Map<String, Object>>>() {
                    }
            );
            List<Map<String, Object>> users = response.getBody();
            if (users == null || users.isEmpty()) {
                return;
            }
            String title = song.getSongTitle() == null ? "" : song.getSongTitle();
            String encodedTitle = URLEncoder.encode(title, StandardCharsets.UTF_8);
            for (Map<String, Object> u : users) {
                Object emailObj = u.get("email");
                if (emailObj == null) {
                    continue;
                }
                String email = emailObj.toString();
                if (email.isEmpty()) {
                    continue;
                }
                String encodedEmail = URLEncoder.encode(email, StandardCharsets.UTF_8);
                String url = mailServiceUrl + "/mail/song/added?email=" + encodedEmail + "&songTitle=" + encodedTitle;
                restTemplate.postForEntity(url, null, String.class);
            }
        } catch (Exception e) {
        }
    }
}
