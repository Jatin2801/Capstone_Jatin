package com.micro.song.service;

import com.micro.song.entity.Song;
import com.micro.song.repository.SongRepository;
import com.micro.song.controller.SongController.FileInfo;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.nio.file.*;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class SongService {

    private final SongRepository repo;

    @Value("${song.file.storage}")
    private String storageDir;

    public SongService(SongRepository repo) {
        this.repo = repo;
    }

    public List<Song> all() { return repo.findAll(); }

    public Optional<Song> get(Integer id) { return repo.findById(id); }

    public Song save(Song s) { return repo.save(s); }

    public Song saveWithFile(Song s, MultipartFile file) throws IOException {
        if (file != null && !file.isEmpty()) {
            ensureStorageExists();

            String unique = UUID.randomUUID() + file.getOriginalFilename();
            Path path = Paths.get(storageDir).resolve(unique);

            Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);

            s.setFileName(file.getOriginalFilename());
            s.setFileType(file.getContentType());
            s.setFileSize(file.getSize());
            s.setFilePath(path.toString());
        }

        return repo.save(s);
    }

    public Song updateWithFile(Integer id, Song newData, MultipartFile file) throws IOException {
        var opt = repo.findById(id);
        if (opt.isEmpty()) return null;

        Song s = opt.get();

        // copy normal fields
        s.setSongTitle(newData.getSongTitle());
        s.setGenre(newData.getGenre());
        s.setMusicDirector(newData.getMusicDirector());
        s.setSinger(newData.getSinger());
        s.setReleaseDate(newData.getReleaseDate());
        s.setAlbumName(newData.getAlbumName());
        s.setSongType(newData.getSongType());
        s.setSongStatus(newData.getSongStatus());

        // update file if uploaded
        if (file != null && !file.isEmpty()) {
            ensureStorageExists();

            // delete old file
            if (s.getFilePath() != null) {
                try { Files.deleteIfExists(Paths.get(s.getFilePath())); } catch (Exception ignored) {}
            }

            String unique = UUID.randomUUID() + file.getOriginalFilename();
            Path path = Paths.get(storageDir).resolve(unique);

            Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);

            s.setFileName(file.getOriginalFilename());
            s.setFileType(file.getContentType());
            s.setFileSize(file.getSize());
            s.setFilePath(path.toString());
        }

        return repo.save(s);
    }

    public void delete(Integer id) {
        repo.findById(id).ifPresent(song -> {
            if (song.getFilePath() != null) {
                try { Files.deleteIfExists(Paths.get(song.getFilePath())); } catch (Exception ignored) {}
            }
            repo.delete(song);
        });
    }

    public FileInfo getFileResource(Integer id) throws IOException {
        var opt = repo.findById(id);
        if (opt.isEmpty()) return null;

        Song s = opt.get();
        if (s.getFilePath() == null) return null;

        Path p = Paths.get(s.getFilePath());
        if (!Files.exists(p)) return null;

        return new FileInfo(
                Files.newInputStream(p),
                s.getFileName(),
                s.getFileType(),
                s.getFileSize()
        );
    }

    private void ensureStorageExists() throws IOException {
        Path dir = Paths.get(storageDir);
        if (!Files.exists(dir)) Files.createDirectories(dir);
    }
}
