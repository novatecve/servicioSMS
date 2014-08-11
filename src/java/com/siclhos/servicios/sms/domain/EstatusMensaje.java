/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.siclhos.servicios.sms.domain;

import java.util.Date;

/**
 *
 * @author YasminV
 */
public class EstatusMensaje {
    Integer id;
    Mensaje mensaje;
    Estatus estatus;
    Date    fecha;
    Lote    lote;
}
