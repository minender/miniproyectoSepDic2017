package com.howtodoinjava.dao;

import java.util.List;
import com.howtodoinjava.entity.Usuario;

public interface UsuarioDAO 
{
    public void addUsuario(Usuario usuario);
    public List<Usuario> getAllUsuarios();
    public void deleteUsuario(Integer usuarioId);
    public Usuario getUsuario(String login);
}
