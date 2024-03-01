WITH ClientInfo AS ( SELECT id, saldo, limite FROM clientes WHERE id = #{id})
    SELECT ci.limite, ci.saldo, t.valor, t.tipo, t.descricao, t.inserted_at
    FROM ClientInfo ci
    INNER JOIN transacoes t ON ci.id = t.cliente_id
    WHERE ci.id = #{id}
    ORDER BY t.inserted_at DESC;